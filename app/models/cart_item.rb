# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint
#  invoice_id :bigint
#  product_id :bigint
#
# Indexes
#
#  index_cart_items_on_cart_id     (cart_id)
#  index_cart_items_on_invoice_id  (invoice_id)
#  index_cart_items_on_product_id  (product_id)
#
class CartItem < ApplicationRecord

  # Relations
  belongs_to :cart, inverse_of: :cart_items
  belongs_to :product, inverse_of: :cart_items
  belongs_to :invoice, inverse_of: :cart_items, optional: true

  # Scopes
  scope :processed, -> { where.not(invoice_id: nil) }
  scope :unprocessed, -> { where(invoice_id: nil) }

  # Validators
  validates :cart, :product, presence: true

  # Instance methods
  def total_price
    counter * product.price
  end
end
