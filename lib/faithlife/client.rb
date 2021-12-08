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

    def self.oauth_consumer(group_id, consumer_key, consumer_secret)
      raise Faithlife::Exceptions::FaithlifeStandardError, 'Group id, consumer key and consumer secret cannot be blank' if group_id.nil? || consumer_key.nil? || consumer_secret.nil?

      OAuth::Consumer.new(
        consumer_key,
        consumer_secret,
        site: 'https://auth.faithlife.com',
        request_token_path: '/v1/temporarytoken',
        access_token_path: '/v1/accesstoken',
        authorize_path: '/v1/authorize',
        signature_method: 'PLAINTEXT'
        # debug_output: true
      )
    end

    private

    def base_url
      'https://givingapi.faithlife.com'
    end

    def oauth_params(method)
      consumer = OAuth::Consumer.new(
        @consumer_key,
        @consumer_secret,
        site: base_url,
        http_method: method,
        signature_method: 'PLAINTEXT'
        # debug_output: true
      )
      access_token = OAuth::AccessToken.new(consumer, @oauth_token, @oauth_secret)
      { consumer: consumer, token: access_token }
    end

    def request(method, path, key_name, options = {}, body = nil)
      params = format_params(options)
      request_url = "#{base_url}#{path}".gsub(/GROUP_ID/, @group_id)
      # puts "request_url: #{request_url}, params: #{params.inspect}, body: #{body.inspect}"

      hydra = Typhoeus::Hydra.new
      req = Typhoeus::Request.new(
        request_url, method: method, params: params, body: body
      )
      req.options[:headers]['Content-Type'] = 'application/json'
      oauth_helper = OAuth::Client::Helper.new(
        req, oauth_params(method).merge(request_uri: request_url)
      )
      req.options[:headers]['Authorization'] = oauth_helper.header # Signs the request
      hydra.queue(req)
      hydra.run

      ResponseHandler.new(req.response, key_name).call
    end

    def format_params(options)
      options.each_with_object({}) do |(key, value), params|
        value = format_datetime(key, value) if value.is_a?(Date)
        params[key] = value
      end
    end

    def format_datetime(key, value)
      case key
      when :from, :start
        value.strftime('%Y-%m-%dT00:00:00Z') # beginning of day
      when :to, :end
        value.strftime('%Y-%m-%dT23:59:59Z') # end of day
      else
        raise Faithlife::Exceptions::InvalidInputError,
              "The client does not know what timestamp to place on the '#{key}' parameter"
      end
    end
  end
end
