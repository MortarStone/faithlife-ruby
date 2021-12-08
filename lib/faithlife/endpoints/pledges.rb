# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Pledges
      def pledges(params = {})
        request(
          :post,
          "/v1/merchant/GROUP_ID/pledges/list", # singular 'merchant'!
          {},
          params.to_json
        )
      end
    end
  end
end
