# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Transactions do
  describe '#transactions', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @transactions = @client.transactions(
        start: Date.new(2020, 1, 1),
        end: Date.new(2020, 1, 15)
      )
    end

    it 'returns an array' do
      expect(@transactions).to be_an(Array)
    end

    it 'returns transactions objects' do
      expect(@transactions.first).to be_a(Hash)
      expect(@transactions.first[:id]).to_not be_nil
    end
  end
end
