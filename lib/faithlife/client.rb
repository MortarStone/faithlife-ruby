# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/auto_load.rb"

module Faithlife
  class Client
    include Faithlife::Endpoints::Campaigns
    include Faithlife::Endpoints::FundGroupings
    include Faithlife::Endpoints::Funds
    include Faithlife::Endpoints::GiftSchedules
    include Faithlife::Endpoints::Gifts
    include Faithlife::Endpoints::Givers
    include Faithlife::Endpoints::Pledges

    def initialize(options)
      @group_id = options[:group_id]
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @oauth_token = options[:oauth_token]
      @oauth_secret = options[:oauth_secret]
    end

    def self.oauth_consumer(consumer_key, consumer_secret)
      raise Faithlife::Exceptions::F1StandardError, 'Group id, consumer key and consumer secret cannot be blank' if group_id.nil? || consumer_key.nil? || consumer_secret.nil?

      OAuth::Consumer.new(
        consumer_key,
        consumer_secret,
        site: base_url,
        request_token_path: '/v1/temporarytoken',
        access_token_path: '/v1/accesstoken',
        authorize_path: '/v1/authorize'
      )
    end

    private

    def base_url
      "https://givingapi.faithlife.com"
    end

    def oauth_params(method)
      consumer = OAuth::Consumer.new(
        @consumer_key,
        @consumer_secret,
        site: base_url,
        http_method: method
      )
      access_token = OAuth::AccessToken.new(consumer, @oauth_token, @oauth_secret)
      { consumer: consumer, token: access_token }
    end

    def request(method, path, options = {}, body = nil)
      params = format_params(options.to_camelback_keys)
      oauth_params = oauth_params(method)
      request_url = "#{base_url}#{path}".gsub(/GROUP_ID/, @group_id)
      puts "request_url: #{request_url}, params: #{params.inspect}"

      hydra = Typhoeus::Hydra.new
      req = Typhoeus::Request.new(request_url, method: method, params: params, body: body)
      req.options[:headers]['Content-Type'] = 'application/json'
      oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(request_uri: request_url))
      req.options[:headers]['Authorization'] = oauth_helper.header # Signs the request
      hydra.queue(req)
      hydra.run

      response = req.response
      puts response.inspect
      binding.pry
      # response_check(response)
    end

    def response_check(response)
      response_body = response.response_body
      return response unless response_body.empty?

      response_status = response.response_headers.gsub(/\r|\n.*/, '')
      return response if response_status.include?('HTTP/1.1 200 OK')

      # VCR cassettes in donors store the value in 'code' instead of response_code. Weird.
      response_code = response.options[:response_code] || response.options[:code]
      handle_response_code(response_code, response_status)
    end

    def handle_response_code(response_code, response_status)
      case response_code
      when 404
        # If the object is not found (404 error), we do not want to raise an error,
        # we just want to return nil.
        nil
      when 401
        raise Faithlife::Exceptions::BadCredentialsError, response_status
      when 403
        raise Faithlife::Exceptions::MissingPermissionsError, response_status
      else
        raise Faithlife::Exceptions::ResponseError, response_status
      end
    end

    def request_single_object(method, path, hash_key_name, options)
      response = request(method, path, options)
      return nil if response.nil?

      json_obj = JSON.parse(response.body, symbolize_names: true)[hash_key_name]
      rename_hash_keys(json_obj).to_snake_keys
    end

    def request_multiple_objects(method, path, hash_key_name, options)
      response = request(method, path, options)
      return nil if response.nil?

      json_obj = JSON.parse(response.body, symbolize_names: true)[hash_key_name]
      return [] if json_obj.nil?

      rename_hash_keys(json_obj).to_snake_keys
    end

    def default_pagination_params
      { page: 1, records_per_page: 20 }
    end

    def request_search(path, hash_key_name, options, valid_search_params)
      set_search_params(options, valid_search_params)
      options = default_pagination_params.merge(options)
      response = request(:get, path, options)
      return nil if response.nil?

      json_obj = JSON.parse(response.body, symbolize_names: true)[:results]
      results = rename_hash_keys(json_obj[hash_key_name])
      return [] if results.nil?

      results.to_snake_keys
    end

    def set_search_params(options, valid_search_params)
      invalid_params = options.keys - valid_search_params
      return if invalid_params.empty?

      raise Faithlife::Exceptions::InvalidOptionsError, "Invalid params sent: #{invalid_params.join(', ')}"
    end

    def format_params(options)
      retval = {}
      options.each { |k, v| retval[k.to_s.gsub(/Id$/, 'ID').to_sym] = v }
      retval
    end

    # recursively changes keys to remove a leading '@' in the key name
    def rename_hash_keys(data)
      return nil if data.nil?

      return data.each_with_object([]) { |e, arr| arr << rename_hash_keys(e) } if data.is_a?(Array)

      data.each_with_object({}) do |(key, value), hsh|
        # puts "#{key}: #{value}"
        if value.is_a?(Hash) || value.is_a?(Array)
          hsh[key] = rename_hash_keys(value)
        elsif key.to_s.start_with?('@')
          new_key = key.to_s.delete('@').to_sym
          hsh[new_key] = data[key]
        else
          hsh[key] = data[key]
        end
      end
    end
  end
end
