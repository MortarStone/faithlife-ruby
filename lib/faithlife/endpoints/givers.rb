# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Givers
      def givers(params = {})
        request(
          :post,
          "/v1/merchant/GROUP_ID/givers/list", # singular 'merchant'!
          :givers,
          {},
          params.to_json
        )
      end
    end
  end
end
