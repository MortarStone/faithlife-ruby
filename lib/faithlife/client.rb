# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/auto_load.rb"

module Faithlife
  class Client
    include Faithlife::Endpoints::Campaigns
    include Faithlife::Endpoints::Families
    include Faithlife::Endpoints::FundGroupings
    include Faithlife::Endpoints::Funds
    include Faithlife::Endpoints::GiftSchedules
    include Faithlife::Endpoints::Gifts
    include Faithlife::Endpoints::Givers
    include Faithlife::Endpoints::Organizations
    include Faithlife::Endpoints::People
    include Faithlife::Endpoints::Pledges

    def initialize(options)
      @chms_group_id = options[:chms_group_id]
      @giving_group_id = options[:giving_group_id]
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @oauth_token = options[:oauth_token]
      @oauth_secret = options[:oauth_secret]
    end

    def self.oauth_consumer(chms_group_id, giving_group_id, consumer_key, consumer_secret)
      if chms_group_id.nil? || giving_group_id.nil? || consumer_key.nil? || consumer_secret.nil?
        raise Faithlife::Exceptions::FaithlifeStandardError,
              'ChMS group id, giving_group_id, consumer key and consumer secret ' \
              'cannot be blank'
      end

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

    def oauth_params(method)
      consumer = OAuth::Consumer.new(
        @consumer_key,
        @consumer_secret,
        site: 'https://givingapi.faithlife.com',
        http_method: method,
        signature_method: 'PLAINTEXT'
        # debug_output: true
      )
      access_token = OAuth::AccessToken.new(consumer, @oauth_token, @oauth_secret)
      { consumer: consumer, token: access_token }
    end

    def request(method, request_url, key_name, params = {}, body = nil)
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
  end
end
