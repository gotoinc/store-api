# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Customer project API' do
  path '/api/v1/customer/products' do
    let!(:customer) {
      stub_jwt_verification(controller: Api::V1::Customer::ProductsController, payload: { role: :customer })
    }
    let!(:products) { create_list(:product, rand(1..5), owner: create(:user, role: :provider)) }

    get 'Show list of products #customer' do
      tags '#index'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Customer able to see list of products' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body).fetch('data', [])

          expect(data.size).to eq(products.count)
        end
      end
    end
  end

  path '/api/v1/customer/products/{id}' do
    parameter name: :id, in: :path, type: :string
    let!(:customer) {
      stub_jwt_verification(controller: Api::V1::Customer::ProductsController, payload: { role: :customer })
    }
    let(:product) { create(:product, owner: create(:user, role: :provider)) }
    let(:id) { product.uuid }

    get 'Show product #customer' do
      tags '#show'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Able to see specific product' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body)
          product_uuid = data.dig('data', 'attributes', 'uuid')

          expect(product.uuid).to eq(product_uuid)
        end
      end
    end
  end
end
