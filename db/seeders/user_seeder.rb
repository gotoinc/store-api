# frozen_string_literal: true

class UserSeeder

  attr_reader :provider_data,
              :category,
              :user_role

  def initialize(role: :customer, category: nil)
    @user_role = role
    @category = category
    @provider_data = {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      password: 'password',
      email: FFaker::Internet.email,
    }
  end

  def seed
    User.find_or_create_by(email: provider_data[:email]) do |user|
      user.assign_attributes(provider_data)
      user.role = user_role
      user.category = category
      user.confirmed_at = DateTime.now
    end
  end
end
