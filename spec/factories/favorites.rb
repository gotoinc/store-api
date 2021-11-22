# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_favorites_on_product_id  (product_id)
#  index_favorites_on_user_id     (user_id)
#
FactoryBot.define do
  factory :favorite do
    # pending
  end
end
