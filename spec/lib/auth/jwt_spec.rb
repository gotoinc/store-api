# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Auth::Jwt do
  describe 'class methods' do
    describe '::encode' do
      let!(:params) { { some_key: 'some value' } }

      it 'should return encoded string' do
        token = described_class.encode(params)
        expect(token.is_a?(String)).to be_truthy
      end

      it 'JWT::encode should be called' do
        expect(JWT).to receive(:encode)
        described_class.encode(params)
      end
    end

    describe '::encode' do
      let!(:params) { { some_key: 'some value' } }
      let!(:token) { described_class.encode(params) }

      it 'should return decoded hash' do
        params = described_class.decode(token)
        expect(params.is_a?(Hash)).to be_truthy
      end

      it 'JWT::decode should be called' do
        expect(JWT).to receive(:decode).and_return([{}])
        described_class.decode(token)
      end

      it 'should have expected data' do
        result = described_class.decode(token)
        expect(result.keys).to match_array(['some_key', 'exp'])
        expect(result[:some_key]).to eq('some value')
      end
    end
  end
end
