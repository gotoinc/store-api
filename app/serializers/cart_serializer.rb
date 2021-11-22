# frozen_string_literal: true

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
class CartSerializer < BaseSerializer

  attributes :total_price

  has_many :cart_items
  has_one :user

  # attribute :confirmed do |record|
  #   record.confirmed_at.present?
  # end
  #
  # attribute :photo do |record|
  #   file = record.photo
  #
  #   file.presence && file.attached? ? { filename: file.filename, file_url: file.url } : {}
  # end
end
