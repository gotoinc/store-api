# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord

  # Relations
  has_many :categories_products, inverse_of: :category, dependent: :destroy
  has_many :products, through: :categories_products

  # Validators
  validates :name, presence: true
end
