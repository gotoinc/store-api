# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:categories_products) }
    it { should have_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
