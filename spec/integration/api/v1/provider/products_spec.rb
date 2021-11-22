# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Provider project API' do
  path '/api/v1/provider/products' do
    let(:provider) {
      stub_jwt_verification(controller: Api::V1::Provider::ProductsController, payload: { role: :provider })
    }
    let!(:products) { create_list(:product, rand(1..5), owner: provider) }

    get 'List of available products' do
      tags '#index'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Provider able to see list of his products' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body).fetch('data', [])

          expect(data.size).to eq(provider.products.count)
        end
      end
    end

    post 'Create a new product' do
      tags '#create'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :product_params, in: :body, schema: {
        type: :object,
        properties: {
          name: {
            type: :string,
            default: 'name'
          },
          description: {
            type: :string,
            default: 'description'
          },
          price: {
            type: :number,
            format: :float,
            default: 0.0
          },
          counter: {
            type: :number,
            default: 0
          }
        }
      }

      response '200', 'Provider able to create a new product' do
        let(:Authorization) { 'Bearer JWT' }
        let!(:provider) {
          stub_jwt_verification(controller: Api::V1::Provider::ProductsController, payload: { role: :provider })
        }
        let(:product_params) { attributes_for(:product) }

        run_test! do |response|
          data = JSON.parse(response.body).fetch('data', [])

          expect(response.status).to eq(200)
          expect(data['id'].to_i).to eq(provider.reload.products.last.id)
        end
      end
    end
  end

  path '/api/v1/provider/products/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:provider) {
      stub_jwt_verification(controller: Api::V1::Provider::ProductsController, payload: { role: :provider })
    }
    let(:product) { create(:product, owner: provider) }
    let(:id) { product.uuid }

    get 'Show product #provider' do
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

    delete 'Provider able to delete a project' do
      tags '#destroy'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Product deleting' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body)
          product_uuid = data.dig('data', 'attributes', 'uuid')

          expect(product.uuid).to eq(product_uuid)
          expect(provider.products.reload.count).to eq(0)
        end
      end
    end
  end
end
