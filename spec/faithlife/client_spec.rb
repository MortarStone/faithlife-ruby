# frozen_string_literal: true

require "#{File.dirname(__FILE__)}/../spec_helper"

RSpec.describe Faithlife::Client do
  describe '#connect', :vcr do
    context 'with valid client_id and client_secret' do
      it 'creates a connection' do
        client = FactoryBot.build(:client)
        expect(client).to be_a(Faithlife::Client)
      end
    end

    context 'with invalid credentials' do
      it 'raises an error' do
        invalid_client = FactoryBot.build(:invalid_client)
        expect do
          invalid_client.gift(1)
        end.to raise_error(Faithlife::Exceptions::BadRequestError)
      end
    end
  end
end
