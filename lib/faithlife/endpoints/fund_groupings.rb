# frozen_string_literal: true

module Faithlife
  module Endpoints
    module FundGroupings
      def fund_groupings(params = {})
        request(
          :get,
          '/v1/merchants/GROUP_ID/fundGroupings',
          :fundGroupings,
          params
        )
      end
    end
  end
end
