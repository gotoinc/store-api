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
class Invoice < ApplicationRecord

  # Relations
  belongs_to :cart
  has_one :user, through: :cart
  has_many :cart_items, through: :cart

  # Validators
  validates :cart, presence: true
end
