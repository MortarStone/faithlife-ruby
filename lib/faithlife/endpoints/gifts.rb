# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Gifts
      def gifts(params = {})
        request(
          :get,
          '/v1/merchants/GROUP_ID/gifts',
          :gifts,
          params
        )
      end

      def gift(id, params = {})
        request(
          :get,
          "/v1/merchants/GROUP_ID/gifts/#{id}",
          :gift,
          params
        )
      end
    end
  end
end
