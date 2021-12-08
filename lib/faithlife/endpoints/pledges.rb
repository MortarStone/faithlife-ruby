# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Pledges
      def pledges(params = {})
        request_multiple_objects(
          :post,
          "/merchants/GROUP_ID/pledges/fetch",
          %w[pledges],
          params
        )
      end
    end
  end
end
