# frozen_string_literal: true

module Faithlife
  class ResponseHandler
    attr_accessor :response, :key_name

    def initialize(response, key_name)
      @response = response
      @key_name = key_name
    end

    def call
      return nil if response.nil?

      handle_response
    end

    private

    def handle_response
      case response.code
      when 200..299
        format_response
      when 302
        raise Faithlife::Exceptions::RedirectError, error_messages
      when 400
        raise Faithlife::Exceptions::BadRequestError, error_messages
      when 401
        raise Faithlife::Exceptions::UnauthorizedError, error_messages
      when 403
        raise Faithlife::Exceptions::ForbiddenError, error_messages
      when 404
        raise Faithlife::Exceptions::NotFoundError, error_messages
      when 405
        raise Faithlife::Exceptions::MethodNotAllowedError, error_messages
      when 500
        raise Faithlife::Exceptions::ResponseError, error_messages
      else
        raise Faithlife::Exceptions::FaithlifeStandardError, error_messages
      end
    end

    def error_messages
      return if response.body == ''

      JSON.parse(response.body)['message']
    end

    def format_response
      obj = JSON.parse(response.body, symbolize_names: true)
      obj[:objects] = obj.delete(key_name)
      obj
    end
  end
end
