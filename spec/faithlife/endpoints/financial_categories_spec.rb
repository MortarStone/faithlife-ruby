# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::FinancialCategories do
  describe '#financial_categories', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @financial_categories = @client.financial_categories
    end

    it 'returns an array' do
      expect(@financial_categories).to be_an(Array)
    end

    it 'returns financial_categories objects' do
      expect(@financial_categories.first).to be_a(Hash)
      expect(@financial_categories.first[:id]).to_not be_nil
    end
  end
end
