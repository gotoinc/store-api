# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let!(:user) { create(:user) }

  describe 'schema matching' do
    let!(:schema_fixture) { file_fixture('user.json') }
    let!(:schema) { schema_fixture.read }

    context 'without :include option' do
      let!(:serializer) { described_class.new(user) }

      it 'matches with schema' do
        expect(JSON::Validator.validate!(schema, serializer.serializable_hash, strict: true)).to be_truthy
      end
    end
  end
end
