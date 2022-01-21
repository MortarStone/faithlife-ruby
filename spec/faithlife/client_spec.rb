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
  end
end
