# frozen_string_literal: true

module Faithlife
  module Exceptions
    class FaithlifeStandardError < StandardError
    end

    class InvalidInputError < FaithlifeStandardError
    end

    class ConnectionError < FaithlifeStandardError
    end

    class BadRequestError < FaithlifeStandardError
    end

    class UnauthorizedError < FaithlifeStandardError
    end

    class ForbiddenError < FaithlifeStandardError
    end

    class NotFoundError < FaithlifeStandardError
    end

    class ResponseError < FaithlifeStandardError
    end
  end
end
