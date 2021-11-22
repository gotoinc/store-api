# frozen_string_literal: true

module Invoices
  class UpdatingService

    attr_reader :params, :invoice, :admin

    def initialize(params:, invoice:, admin:)
      @params = params
      @invoice = invoice
      @admin = admin
    end

    def call
      invoice.activate! && publisher if invoice_paid?
      invoice.reschedule! if invoice_scheduled?

      invoice.save!
      invoice
    end

    private

    def invoice_params
      params.permit(:status)
    end

    def invoice_status
      invoice_params[:status]
    end

    def invoice_paid?
      invoice_params.present? && invoice.may_activate? && invoice_status == 'paid'
    end

    def invoice_scheduled?
      invoice_params.present? && invoice_status == 'scheduled'
    end

    def publisher
      Publishers::NotificationPublisher.new(
        action: :invoice_approved,
        customer: invoice.user,
        admin: admin,
        resource: invoice
      ).call
    end
  end
end
