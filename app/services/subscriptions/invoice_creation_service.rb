# frozen_string_literal: true

module Subscriptions
  class InvoiceCreationService

    attr_reader :contract, :params

    def initialize(contract, params = {})
      @contract = contract
      @params = params
    end

    def call
      invoice = contract.build_invoice(params)
      invoice.save!
      invoice
    end
  end
end
