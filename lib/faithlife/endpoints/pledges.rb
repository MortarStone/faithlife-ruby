# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Pledges
      def pledges(params = {})
        request(
          :post,
          'https://givingapi.faithlife.com/v1/merchant/GROUP_ID/pledges/list', # singular 'merchant'!
          :pledges,
          {},
          params.to_json
        )
      end
    end
  end
end
