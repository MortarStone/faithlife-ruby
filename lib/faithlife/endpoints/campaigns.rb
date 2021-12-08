# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Campaigns
      def campaigns(params = {})
        request_multiple_objects(
          :get,
          "/merchants/#{ENV['GROUP_ID']}/campaigns",
          %w[campaigns],
          params
        )
      end
    end
  end
end
