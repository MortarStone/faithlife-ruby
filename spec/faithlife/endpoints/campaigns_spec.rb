# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Campaigns do
  describe '#campaigns', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @campaigns = @client.campaigns[:objects]
    end

    it 'returns an array' do
      expect(@campaigns).to be_an(Array)
    end

    it 'returns campaigns objects' do
      expect(@campaigns.first).to be_a(Hash)
      expect(@campaigns.first[:id]).to_not be_nil
    end
  end
end
