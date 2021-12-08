# frozen_string_literal: true

FactoryBot.define do
  factory :client, class: Faithlife::Client do
    access_token { ENV['ACCESS_TOKEN'] }

    initialize_with { new(access_token) }
  end

  factory :invalid_client, class: Faithlife::Client do
    access_token { 'bad' }

    initialize_with { new(access_token) }
  end
end
