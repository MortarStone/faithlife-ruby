# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Gifts
      def gifts(params = {})
        request(
          :get,
          "https://givingapi.faithlife.com/v1/merchants/#{@giving_group_id}/gifts",
          :gifts,
          params
        )
      end

      def gift(id, params = {})
        request(
          :get,
          "https://givingapi.faithlife.com/v1/merchants/#{@giving_group_id}/gifts/#{id}",
          :gift,
          params
        )
      end
    end
  end
end
