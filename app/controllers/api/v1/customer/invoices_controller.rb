# frozen_string_literal: true

module Api
  module V1
    module Customer
      class InvoicesController < ApplicationController

        def index
          render json: InvoiceSerializer.new(collection)
        end

        def create
          render json: InvoiceSerializer.new(cart.generate_latest_invoice(address_params))
        end

        private

        def address_params
          params.require(:invoice).fetch(:address)
        end

        def collection
          @collection = current_user.invoices.order('created_at DESC')
        end

        def cart
          @cart ||= current_user.cart
        end
      end
    end
  end
end
