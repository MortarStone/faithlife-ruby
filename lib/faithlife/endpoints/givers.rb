# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Givers
      def givers(params = {})
        request(
          :post,
          "https://givingapi.faithlife.com/v1/merchant/#{@giving_group_id}/givers/list", # singular 'merchant'!
          :givers,
          {},
          params.to_json
        )
      end
    end
  end
end
