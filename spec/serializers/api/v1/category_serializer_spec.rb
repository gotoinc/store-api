# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategorySerializer, type: :serializer do
  let(:category) { create(:category) }

  describe 'schema matching' do
    let!(:schema_fixture) { file_fixture('category.json') }
    let!(:schema) { schema_fixture.read }

    context 'without :include option' do
      let!(:serializer) { described_class.new(category) }

      it 'matches with schema' do
        expect(JSON::Validator.validate!(schema, serializer.serializable_hash)).to be_truthy
      end
    end
  end
end
