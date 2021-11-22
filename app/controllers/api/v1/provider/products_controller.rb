# frozen_string_literal: true

module Api
  module V1
    module Provider
      class ProductsController < ApplicationController

        INCLUDED_RESOURCES = %i[category].freeze

        load_and_authorize_resource find_by: :uuid, except: %i[index]

        def index
          render json: ProductSerializer.new(collection, include: INCLUDED_RESOURCES)
        end

        def show
          render json: ProductSerializer.new(item, include: INCLUDED_RESOURCES)
        end

        def create
          product = Products::CreationService.new(user: current_user, params: product_params).call

          render json: ProductSerializer.new(product, include: INCLUDED_RESOURCES)
        end

        def update
          project = Products::UpdatingService.new(product: item, params: product_params).call

          render json: ProductSerializer.new(project, include: INCLUDED_RESOURCES)
        end

        def destroy
          render json: ProductSerializer.new(item.destroy)
        end

        private

        def product_params
          params.fetch(:product, {}).permit(:status, :uuid, :name, :description, :price, :counter)
        end

        def collection
          @collection ||= current_user.products.order('created_at DESC')
        end

        def item
          @item = current_user.products.find_by!(uuid: uuid)
        end

        def uuid
          params[:id]
        end
      end
    end
  end
end
