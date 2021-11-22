# frozen_string_literal: true

module Api
  module V1
    module Provider
      class CategoriesController < ApplicationController

        def index
          render json: CategorySerializer.new(collection)
        end

        def create
          category = Category.find_or_create_by(item_params)

          render json: CategorySerializer.new(category)
        end

        private

        def item_params
          params.fetch(:category, {}).permit(:name)
        end

        def collection
          @collection ||= Category.order('created_at DESC')
        end

        def item
          @item = Category.find(item_id)
        end

        def item_id
          params[:category_id]
        end
      end
    end
  end
end
