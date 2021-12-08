# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Givers
      def givers(params = {})
        request_multiple_objects(
          :post,
          "/merchants/#{ENV['GROUP_ID']}/givers/list",
          %w[givers],
          params
        )
      end
    end
  end
end
