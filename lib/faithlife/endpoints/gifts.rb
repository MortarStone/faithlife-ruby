# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Gifts
      def gifts(params = {})
        request_multiple_objects(
          :get,
          "/merchants/#{ENV['GROUP_ID']}/gifts",
          %w[gifts],
          params
        )
      end

      def gift(id, params = {})
        request_single_object(
          :post,
          "/merchants/#{ENV['GROUP_ID']}/gifts/#{id}",
          %w[gift],
          params
        )
      end
    end
  end
end
