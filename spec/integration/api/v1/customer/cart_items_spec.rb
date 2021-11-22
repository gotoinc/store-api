# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Customer cart_items API' do
  let!(:customer) {
    stub_jwt_verification(controller: Api::V1::Customer::CartItemsController, payload: { role: :customer })
  }
  let(:products) { create_list(:product, rand(1..5), owner: create(:user, role: :provider)) }
  let!(:cart_items) {
    customer.cart.cart_items.create(products.sample(3).map { |p| { product_id: p.id, counter: 1 } })
  }

  path '/api/v1/customer/cart' do
    get 'List of products' do
      tags '#index'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Customer able to see list of cart items' do
        let(:Authorization) { 'Bearer JWT' }

        run_test! do |response|
          data = JSON.parse(response.body).fetch('data', [])

          expect(data.size).to eq(customer.cart.products.count)
        end
      end
    end
  end

  path '/api/v1/customer/cart/{id}' do
    parameter name: :id, in: :path, type: :string
    parameter name: :product_params, in: :body, schema: {
      type: :object,
      properties: {
        uuid: {
          type: :string,
          default: 'uuid'
        }
      }
    }

    let(:current_product) { cart_items.first.product }
    let(:id) { current_product.uuid }

    delete 'Customer able to delete a product from cart' do
      tags '#destroy'
      consumes 'application/json'
      security [Bearer: {}]

      response '200', 'Product deleting' do
        let(:Authorization) { 'Bearer JWT' }
        let(:product_params) { { uuid: current_product.uuid } }

        run_test! do |response|
          data = JSON.parse(response.body)
          cart_item_uuid = data.dig('data', 'id')

          expect(cart_items.first.id.to_s).to eq(cart_item_uuid)
        end
      end
    end
  end
end
