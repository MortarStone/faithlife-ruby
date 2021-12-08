# frozen_string_literal: true

module Faithlife
  module Endpoints
    module FundGroupings
      def fund_groupings(params = {})
        request_multiple_objects(
          :get,
          "/merchants/#{ENV['GROUP_ID']}/fundGroupings",
          %w[fundGroupings],
          params
        )
      end
    end
  end
end
