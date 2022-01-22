# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Organizations
      def organizations(params = {})
        request(
          :get,
          'https://faithlife.com/proxy/chms/v1/group/GROUP_ID/records/organization/get',
          :records,
          { schemaVersion: '2.0.2' }.merge(params)
        )
      end
    end
  end
end
