# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Campaigns
      def campaigns(params = {})
        request(
          :get,
          '/v1/merchants/GROUP_ID/campaigns',
          :campaigns,
          params
        )
      end
    end
  end
end
