# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Funds do
  describe '#funds', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @funds = @client.funds[:funds]
    end

    it 'returns an array' do
      expect(@funds).to be_an(Array)
    end

    it 'returns funds objects' do
      expect(@funds.first).to be_a(Hash)
      expect(@funds.first[:id]).to_not be_nil
    end
  end
end
