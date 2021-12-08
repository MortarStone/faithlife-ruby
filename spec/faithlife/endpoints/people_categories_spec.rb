# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::PeopleCategories do
  describe '#people_categories', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @people_categories = @client.people_categories
    end

    it 'returns an array' do
      expect(@people_categories).to be_an(Array)
    end

    it 'returns people_categories objects' do
      expect(@people_categories.first).to be_a(Hash)
      expect(@people_categories.first[:id]).to_not be_nil
    end
  end
end
