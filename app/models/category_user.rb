# == Schema Information
#
# Table name: category_users
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_category_users_on_category_id              (category_id)
#  index_category_users_on_category_id_and_user_id  (category_id,user_id)
#  index_category_users_on_user_id                  (user_id)
#  index_category_users_on_user_id_and_category_id  (user_id,category_id)
#
class CategoryUser < ApplicationRecord

  # Relations
  belongs_to :user
  belongs_to :category
end
