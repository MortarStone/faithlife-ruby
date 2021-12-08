# frozen_string_literal: true

module Faithlife
  module Endpoints
    module GiftSchedules
      def gift_schedules(params = {})
        request_multiple_objects(
          :get,
          "/merchants/#{ENV['GROUP_ID']}/giftschedules",
          %w[giftSchedules],
          params
        )
      end

      def gift(id, params = {})
        request_single_object(
          :get,
          "/giftSchedules/#{id}",
          %w[giftSchedule],
          params
        )
      end
    end
  end
end
