# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::GiftSchedules do
  describe '#gift_schedules', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @gift_schedules = @client.gift_schedules[:giftSchedules]
    end

    it 'returns an array' do
      expect(@gift_schedules).to be_an(Array)
    end

    it 'returns gift_schedules objects' do
      expect(@gift_schedules.first).to be_a(Hash)
      expect(@gift_schedules.first[:id]).to_not be_nil
    end
  end
end
