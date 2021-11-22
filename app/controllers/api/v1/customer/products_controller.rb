# frozen_string_literal: true

module Api
  module V1
    module Customer
      class ProductsController < ApplicationController

        INCLUDED_RESOURCES = %i[category].freeze

        load_and_authorize_resource find_by: :uuid, except: %i[index]

        def index
          render json: ProductSerializer.new(collection, include: INCLUDED_RESOURCES)
        end

        def show
          render json: ProductSerializer.new(item, include: INCLUDED_RESOURCES)
        end

        private

        def collection
          @collection ||= Product.order('created_at DESC')
        end

        def item
          @item = Product.find_by!(uuid: uuid)
        end

        def uuid
          params[:id]
        end
      end
    end
  end
end
