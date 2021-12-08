# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::FundGroupings do
  describe '#fund_groupings', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @fund_groupings = @client.fund_groupings[:objects]
    end

    it 'returns an array' do
      expect(@fund_groupings).to be_an(Array)
    end

    it 'returns fund_groupings objects' do
      expect(@fund_groupings.first).to be_a(Hash)
      expect(@fund_groupings.first[:id]).to_not be_nil
    end
  end
end
