# frozen_string_literal: true

module Faithlife
  module Endpoints
    module Families
      def families(params = {})
        request(
          :get,
          "https://faithlife.com/proxy/chms/v1/group/#{@chms_group_id}/records/family/get",
          :records,
          { schemaVersion: '3.1.7' }.merge(params)
        )
      end
    end
  end
end
