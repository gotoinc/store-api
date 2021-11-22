# frozen_string_literal: true

# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  address     :string
#  total_price :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cart_id     :bigint
#
# Indexes
#
#  index_invoices_on_cart_id  (cart_id)
#
class InvoiceSerializer < BaseSerializer

  attributes :address

  has_one :cart

  attribute :total_price do |record|
    record.cart.total_price
  end
end
