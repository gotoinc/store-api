# frozen_string_literal: true

class AdminSeeder
  DATA = {
    first_name: 'Admin',
    last_name: 'Admin',
    password: 'password',
    email: 'admin@example.com',
    role: :admin
  }.freeze

  def seed
    User.find_or_create_by(email: DATA[:email]) do |user|
      user.assign_attributes(DATA)
      user.confirmed_at = DateTime.now
    end
  end
end
