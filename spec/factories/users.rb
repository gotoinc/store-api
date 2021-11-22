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
FactoryBot.define do
  factory :user do
    sequence(:first_name) { FFaker::Name.first_name }
    sequence(:last_name) { FFaker::Name.last_name }
    sequence(:email) { FFaker::Internet.email }
    sequence(:password) { 'Password1' }
    sequence(:role) { 'customer' }
    sequence(:confirmed_at) { Time.zone.now }
    before(:create) do |record|
      record.category = Category.first || create(:category) if record.provider?

      # Attach fake avatar
      file_path = Rails.root.join('db', 'seeders', 'fixtures', 'avatar.png')
      record.photo.attach(io: File.open(file_path), filename: File.basename(file_path))
    end
  end
end
