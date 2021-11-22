# frozen_string_literal: true

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
class ProductSerializer < BaseSerializer

  attributes :status, :uuid, :name, :description, :price, :counter, :created_at, :updated_at

  has_one :category, serializer: CategorySerializer
  has_one :user, serializer: UserSerializer

  attribute :photo do |record|
    file = record.photo

    file.presence && file.attached? ? { uploaded_at: file.created_at, file_url: file.url } : {}
  end
end
