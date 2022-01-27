# frozen_string_literal: true

module Faithlife
  module Endpoints
    module GiftSchedules
      def gift_schedules(params = {})
        request(
          :get,
          "https://givingapi.faithlife.com/v1/merchants/#{@giving_group_id}/giftschedules",
          :giftSchedules,
          params
        )
      end
    end
  end
end
