# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Customer API' do
  path '/auth/registrations' do
    post 'Sign-up customer' do
      tags '#auth'
      consumes 'application/json'

      parameter name: :new_user_params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          first_name: { type: :string },
          last_name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email first_name last_name password password_confirmation]
      }

      response '200', 'Unauthenticated user is able to sign up' do
        let(:new_user_params) do
          attributes_for(:user)
            .merge(password_confirmation: 'Password1')
        end

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
