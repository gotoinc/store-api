# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
class Cart < ApplicationRecord

  # Relations
  belongs_to :user, inverse_of: :cart
  has_many :cart_items, inverse_of: :cart, dependent: :destroy
  has_many :products, inverse_of: :carts, dependent: :destroy, through: :cart_items
  has_many :invoices, dependent: :destroy

  # Validators
  validates :user, presence: true

  # Instance methods
  def total_price
    cart_items.sum(&:total_price)
  end

  def generate_latest_invoice(address = nil)
    return if cart_items.unprocessed.present?

    invoice = invoices.create!(total_price: total_price, address: address)
    cart_items.unprocessed.update(invoice: invoice)

    invoice
  end
end
