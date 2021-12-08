# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Endpoints::CustomFields do
  describe '#custom_fields', :vcr do
    before do
      @client = FactoryBot.build(:client)
      @custom_fields = @client.custom_fields
    end

    it 'returns an array' do
      expect(@custom_fields).to be_an(Array)
    end

    it 'returns custom_fields objects' do
      expect(@custom_fields.first).to be_a(Hash)
      expect(@custom_fields.first[:id]).to_not be_nil
    end
  end
end
