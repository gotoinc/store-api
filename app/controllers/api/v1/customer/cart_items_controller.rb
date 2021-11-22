# frozen_string_literal: true

module Api
  module V1
    module Customer
      class CartItemsController < ApplicationController

        INCLUDED_RESOURCES = %i[product].freeze

        def index
          render json: CartItemSerializer.new(collection, include: INCLUDED_RESOURCES)
        end

        def update
          cart_item.update(counter: counter)

          render json: CartItemSerializer.new(cart_item, include: INCLUDED_RESOURCES)
        end

        def destroy
          render json: CartItemSerializer.new(cart_item.destroy, include: INCLUDED_RESOURCES)
        end

        private

        def collection
          cart.cart_items.unprocessed
        end

        def product_uuid
          params.fetch(:uuid)
        end

        def counter
          params.fetch(:counter)
        end

        def cart
          @cart ||= current_user.cart
        end

        def cart_item
          @cart_item ||= collection.find_by!(product: product)
        end

        def product
          @product ||= Product.find_by!(uuid: product_uuid)
        end
      end
    end
  end
end
