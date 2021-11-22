# frozen_string_literal: true

module Products
  class CreationService

    attr_reader :user,
                :params

    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      product = ::Product.new(params)
      product.owner = user
      product.category = user.category
      product.save!
      product
    end
  end
end
