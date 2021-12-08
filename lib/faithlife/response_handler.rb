# frozen_string_literal: true

module Faithlife
  class ResponseHandler
    attr_accessor :response

    def self.check_response(response)
      obj = new(response)
      obj.run
    end

    def initialize(response)
      @response = response
    end

    def run
      return if response.success?

      exception_class = response_code_exception_class
      raise exception_class, error_messages if exception_class
    end

    private

    def response_code_exception_class
      case response.status
      when 400
        Faithlife::Exceptions::BadRequestError
      when 401
        Faithlife::Exceptions::UnauthorizedError
      when 403
        Faithlife::Exceptions::ForbiddenError
      when 404
        Faithlife::Exceptions::NotFoundError
      when 500
        Faithlife::Exceptions::ResponseError
      else
        Faithlife::Exceptions::FaithlifeStandardError
      end
    end

    def error_messages
      JSON.parse(response.body)['error']['message']
    end
  end
end
