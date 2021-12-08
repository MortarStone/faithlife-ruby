# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/auto_load.rb"

module Faithlife
  class Client
    include Faithlife::Endpoints::Funds

    attr_accessor :default_params

    def initialize(access_token)
      @access_token = access_token
      @url = 'https://api.faithlife.com'
      @default_params = { page_size: 1_000, page: 1 }
    end

    private

    def request_single_object(path, id, hash_chain)
      path += "?id=#{id}"
      response = request(path)
      hash_object = response_hash_object(response, hash_chain)
      # Sometimes, even though you're making a single request, the API is
      # weird and returns an array containing the object.
      hash_object = hash_object.first if hash_object.is_a?(Array)
      hash_object
    end

    def request_multiple_objects(path, hash_chain, options = {})
      options = default_params.merge(options)
      path = "#{path}?#{stringify_params(options)}"
      response = request(path)
      objects_list = response_hash_object(response, hash_chain)
      objects_list = [objects_list] if objects_list.is_a?(Hash)
      objects_list
    end

    def request(path)
      conn = Faraday.new(@url, request: { timeout: 300_000 })
      conn.authorization :Bearer, @access_token
      response = conn.get(path) do |req|
        req.options.timeout = 300 # 5 minutes
      end
      # puts "path = #{path}"
      ResponseHandler.check_response(response)

      return nil if response.body == '[]'

      # results = JSON.parse(response.body, symbolize_names: true)
      # puts "results = #{results.inspect}"
      # results
      JSON.parse(response.body, symbolize_names: true)
    end

    def response_hash_object(response, hash_chain)
      return response if hash_chain.empty?
      return nil if hash_chain.nil?

      current_key = hash_chain.shift.to_sym
      return nil unless response.key?(current_key)

      response_hash_object(response[current_key], hash_chain)
    end

    def stringify_params(options = {})
      arr = []
      options.map do |k, v|
        if v.is_a?(Array)
          arr += v.each_with_index.map { |f, i| "#{k}[#{i}]=#{f}" }
        else
          v = v.strftime('%Y-%m-%d') if v.is_a?(Date)
          arr << "#{k}=#{v}"
        end
      end
      arr.join('&').gsub(' ', '%20')
    end
  end
end
