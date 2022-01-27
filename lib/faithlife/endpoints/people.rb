# frozen_string_literal: true

module Faithlife
  module Endpoints
    module People
      def people(params = {})
        request(
          :get,
          "https://faithlife.com/proxy/chms/v1/group/#{@chms_group_id}/records/people/get",
          :records,
          { schemaVersion: '3.16.1' }.merge(params)
        )
      end
    end
  end
end
