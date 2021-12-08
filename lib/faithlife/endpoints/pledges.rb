# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Campaigns
      def pledges(params = {})
        request_multiple_objects(
          :post,
          "/merchants/#{ENV['GROUP_ID']}/pledges/fetch",
          %w[pledges],
          params
        )
      end
    end
  end
end
