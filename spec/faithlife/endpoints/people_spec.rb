# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::People do
  describe '#people', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @people = @client.people
    end

    it 'returns an array' do
      expect(@people).to be_an(Array)
    end

    it 'returns people objects' do
      expect(@people.first).to be_a(Hash)
      expect(@people.first[:id]).to_not be_nil
    end
  end

  describe '#person', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @person = @client.person('57119a60-1a08-471d-a79c-13bba5317199')
    end

    it 'returns a person object' do
      expect(@person).to be_a(Hash)
      expect(@person[:id]).to eq('57119a60-1a08-471d-a79c-13bba5317199')
    end
  end
end
