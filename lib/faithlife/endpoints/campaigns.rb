# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Campaigns
      def campaigns(params = {})
        request(
          :get,
          "https://givingapi.faithlife.com/v1/merchants/#{@giving_group_id}/campaigns",
          :campaigns,
          params
        )
      end
    end
  end
end
