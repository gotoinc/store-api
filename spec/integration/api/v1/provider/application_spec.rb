# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Provider::ApplicationController do
  let(:user) {
    stub_jwt_verification(controller: Api::V1::Provider::ApplicationController, payload: { role: :provider })
  }

  it 'User check' do
    current_user = User.find_by(id: user.id)

    expect(current_user).to eq(user)
  end
end
