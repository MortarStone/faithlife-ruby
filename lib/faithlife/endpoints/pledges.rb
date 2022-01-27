# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Pledges
      def pledges(params = {})
        request(
          :post,
          "https://givingapi.faithlife.com/v1/merchant/#{@giving_group_id}/pledges/list", # singular 'merchant'!
          :pledges,
          {},
          params.to_json
        )
      end
    end
  end
end
