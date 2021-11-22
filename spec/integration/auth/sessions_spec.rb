# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Customer API' do
  path '/auth/sessions' do
    post 'Sign-in customer' do
      tags '#auth'
      consumes 'application/json'

      parameter name: :current_user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'Unauthenticated user is able to login' do
        let(:user) { create(:user) }
        let(:current_user) { { email: user.email, password: 'Password1' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          user_data = data['data']

          expect(response.status).to eq(200)
          expect(user_data['id']).to eq(user.id.to_s)
        end
      end
    end
  end
end
