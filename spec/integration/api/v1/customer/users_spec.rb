# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Customer API' do
  path '/api/v1/customer/profile' do
    let!(:user) {
      stub_jwt_verification(controller: Api::V1::Customer::UsersController, payload: { role: :customer })
    }

    get 'Fetch user #customer' do
      tags '#show'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'User is able to fetch data' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end

    put 'Update user successfully' do
      tags '#update'
      consumes 'application/json'
      security [Bearer: {}]

      parameter name: :new_user_params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          first_name: { type: :string },
          last_name: { type: :string },
          current_password: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email first_name last_name current_password password password_confirmation]
      }

      response '200', 'User is able to update password' do
        let(:Authorization) { 'Bearer JWT' }

        let(:new_user_params) do
          attributes_for(:user, password: 'Password123')
            .merge(password_confirmation: 'Password123')
            .merge(current_password: 'Password1')
        end

        run_test! do |response|
          expect(response.status).to eq(200)
        end
      end
    end

    put 'Update user unsuccessfully' do
      tags '#update'
      consumes 'application/json'
      security [Bearer: {}]

      parameter name: :new_user_params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          first_name: { type: :string },
          last_name: { type: :string },
          current_password: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email first_name last_name current_password password password_confirmation]
      }

      response '422', 'User is unable to update password' do
        let(:Authorization) { 'Bearer JWT' }

        let(:new_user_params) do
          attributes_for(:user, password: 'password123')
            .merge(password_confirmation: 'password123')
            .merge(current_password: 'Password1')
        end

        run_test! do |response|
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
