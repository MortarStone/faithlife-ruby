# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::People do
  describe '#people', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @people = @client.people[:objects]
    end

    it 'returns an array' do
      expect(@people).to be_an(Array)
    end

    it 'returns people objects' do
      expect(@people.first).to be_a(Hash)
      expect(@people.first[:recordId]).to_not be_nil
    end
  end
end
