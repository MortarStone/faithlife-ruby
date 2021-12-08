# frozen_string_literal: true

module Faithlife
  module Endpoints
    module GiftSchedules
      def gift_schedules(params = {})
        request(
          :get,
          "/v1/merchants/GROUP_ID/giftschedules",
          params
        )
      end
    end
  end
end
