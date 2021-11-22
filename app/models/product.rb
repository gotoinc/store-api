# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  counter     :integer          default(0)
#  description :string
#  name        :string
#  price       :decimal(10, 2)   default(0.0)
#  status      :integer          default("pending")
#  uuid        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
class Product < ApplicationRecord
  STATUSES = %i[pending available].freeze
  ALLOWED_MIME_TYPES = %w[
    image/png
    image/gif
    image/jpeg
    image/webp
  ].freeze

  enum status: STATUSES
  has_secure_token :uuid

  # Attachment initialization
  has_one_attached :photo

  # Validators
  validates :owner, :category, presence: true

  # Relations
  belongs_to :owner, -> { provider }, class_name: 'User', foreign_key: :user_id, inverse_of: :products
  has_many :cart_items, inverse_of: :product, dependent: :destroy
  has_many :carts, dependent: :nullify, inverse_of: :products, through: :cart_items
  has_one :categories_product, inverse_of: :product, dependent: :destroy
  has_one :category, inverse_of: :products, through: :categories_product
end
