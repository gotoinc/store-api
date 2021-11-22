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
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
