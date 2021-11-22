# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  jti                    :string           not null
#  last_name              :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#
class UserSerializer < BaseSerializer
  attributes :email, :first_name, :last_name, :role

  has_one :category, serializer: CategorySerializer
  has_one :cart

  attribute :confirmed do |record|
    record.confirmed_at.present?
  end

  attribute :photo do |record|
    file = record.photo

    file.presence && file.attached? ? { filename: file.filename, file_url: file.url } : {}
  end
end
