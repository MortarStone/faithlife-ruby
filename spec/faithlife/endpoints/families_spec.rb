# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Families do
  describe '#families', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @families = @client.families[:objects]
    end

    it 'returns an array' do
      expect(@families).to be_an(Array)
    end

    it 'returns families objects' do
      expect(@families.first).to be_a(Hash)
      expect(@families.first[:recordId]).to_not be_nil
    end
  end
end
