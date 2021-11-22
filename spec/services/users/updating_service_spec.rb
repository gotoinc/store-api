# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::UpdatingService do
  describe 'Check user updating' do
    let(:user) { create(:user) }
    let(:params) do
      attributes_for(:user, first_name: 'Sunny')
        .merge(last_name: 'Bow')
        .merge(email: 'sb@mail.com')
        .merge(current_password: 'password')
        .merge(password: 'password22')
        .merge(password_confirmation: 'password22')
    end

    it 'User updated' do
      expect(user.first_name).not_to eq(params[:first_name])

      user.update_with_password(params)
      user.assign_attributes(params)

      expect(user.first_name).to eq(params[:first_name])
      expect(user.valid?).to be_truthy
    end
  end
end
