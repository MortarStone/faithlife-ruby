# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Funds
      def funds(params = {})
        request(
          :get,
          "https://givingapi.faithlife.com/v1/merchants/#{@giving_group_id}/funds",
          :funds,
          { 'includeInactiveFunds' => true }.merge(params)
        )
      end
    end
  end
end
