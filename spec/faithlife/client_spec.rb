# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faithlife::Client do
  describe '#connect', :vcr do
    context 'with valid access_token' do
      it 'creates a connection' do
        client = FactoryBot.build(:client)
        expect(client).to be_a(Faithlife::Client)
      end
    end

    context 'with invalid access_token' do
      it 'error on people categories', vcr: 'ccb_error' do
        client = FactoryBot.build(:invalid_client)
        expect do
          client.people_categories
        end.to raise_error(Faithlife::Exceptions::UnauthorizedError)
      end
    end

    context 'when already connected' do
      before(:all) do
        @client = FactoryBot.build(:client)
      end

      it 'returns client' do
        client = @client
        expect(client).to be_a(Faithlife::Client)
      end
    end
  end

  describe '#default_params', :vcr do
    let(:client) { FactoryBot.build(:client) }

    it 'reads default params' do
      expect(client.default_params).to eq(page_size: 1_000, page: 1)
    end

    it 'sets default params' do
      client.default_params = { page_size: 1 }
      expect(client.default_params).to eq(page_size: 1)
    end
  end
end
