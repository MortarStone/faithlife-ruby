# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Funds
      def funds(params = {})
        request(
          :get,
          '/v1/merchants/GROUP_ID/funds',
          { 'includeInactiveFunds' => true }.merge(params)
        )
      end
    end
  end
end
