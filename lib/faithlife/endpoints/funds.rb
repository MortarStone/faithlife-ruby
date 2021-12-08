# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Funds
      def funds(params = {})
        request_multiple_objects(
          :get,
          "/merchants/#{ENV['GROUP_ID']}/funds",
          %w[funds],
          { "includeInactiveFunds" => true }.merge(params)
        )
      end
    end
  end
end
