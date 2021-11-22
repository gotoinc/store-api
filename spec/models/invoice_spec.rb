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
require 'rails_helper'

RSpec.describe Invoice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
