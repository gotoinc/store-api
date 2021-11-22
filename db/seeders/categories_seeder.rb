# frozen_string_literal: true

class CategoriesSeeder
  DATA = %w[google facebook xiaomi apple intel].freeze

  def seed
    DATA.map { |company_name| Category.find_or_create_by(name: company_name) }
  end
end
