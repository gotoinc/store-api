# frozen_string_literal: true

module Products
  class UpdatingService

    attr_reader :params,
                :product

    def initialize(product:, params: {})
      @params = params
      @product = product
    end

    def call
      return product if params.blank?

      product.assign_attributes(params)
      product.save!
      product
    end
  end
end
