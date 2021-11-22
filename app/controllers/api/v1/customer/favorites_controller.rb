# frozen_string_literal: true

module Api
  module V1
    module Customer
      class FavoritesController < ApplicationController
        INCLUDED_RESOURCES = %i[category].freeze

        def index
          render json: ProductSerializer.new(collection, include: INCLUDED_RESOURCES)
        end

        def create
          current_user.favorites.create(product: item)

          render json: ProductSerializer.new(item, include: INCLUDED_RESOURCES)
        end

        def destroy
          favorite = current_user.favorites.where(product: item).first
          favorite.destroy

          render json: ProductSerializer.new(item, include: INCLUDED_RESOURCES)
        end

        private

        def collection
          current_user.favorite_products
        end

        def product_uuid
          params.require(:favorite).fetch(:uuid)
        end

        def item
          @item ||= Product.find_by(uuid: product_uuid)
        end
      end
    end
  end
end
