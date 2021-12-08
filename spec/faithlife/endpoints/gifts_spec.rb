# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Gifts do
  describe '#gifts', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @gifts = @client.gifts[:objects]
    end

    it 'returns an array' do
      expect(@gifts).to be_an(Array)
    end

    it 'returns gifts objects' do
      expect(@gifts.first).to be_a(Hash)
      expect(@gifts.first[:id]).to_not be_nil
    end
  end

  describe '#gift', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @gift = @client.gift(797_594)[:objects]
    end

    it 'returns a gift object' do
      expect(@gift).to be_a(Hash)
      expect(@gift[:id]).to eq(797_594)
    end
  end
end
