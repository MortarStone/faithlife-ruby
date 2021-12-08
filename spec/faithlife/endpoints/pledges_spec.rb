# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Pledges do
  describe '#pledges', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @pledges = @client.pledges[:pledges]
    end

    it 'returns an array' do
      expect(@pledges).to be_an(Array)
    end

    it 'returns pledges objects' do
      expect(@pledges.first).to be_a(Hash)
      expect(@pledges.first[:id]).to_not be_nil
    end
  end
end
