# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::Organizations do
  describe '#organizations', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @organizations = @client.organizations[:objects]
    end

    it 'returns an array' do
      expect(@organizations).to be_an(Array)
    end

    it 'returns organizations objects' do
      expect(@organizations.first).to be_a(Hash)
      expect(@organizations.first[:recordId]).to_not be_nil
    end
  end
end
