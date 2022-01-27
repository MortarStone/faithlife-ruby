# frozen_string_literal: true

FactoryBot.define do
  factory :client, class: Faithlife::Client do
    chms_group_id { ENV['CHMS_GROUP_ID'] }
    giving_group_id { ENV['GIVING_GROUP_ID'] }
    consumer_key { ENV['CONSUMER_KEY'] }
    consumer_secret { ENV['CONSUMER_SECRET'] }
    oauth_token { ENV['OAUTH_TOKEN'] }
    oauth_secret { ENV['OAUTH_SECRET'] }

    factory :invalid_client, class: Faithlife::Client do
      chms_group_id { 'alsdkfj' }
      giving_group_id { 'alsdkfj' }
    end

    initialize_with do
      new(
        chms_group_id: chms_group_id,
        giving_group_id: giving_group_id,
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        oauth_token: oauth_token,
        oauth_secret: oauth_secret
      )
    end
  end
end
