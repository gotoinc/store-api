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
FactoryBot.define do
  factory :product do
    sequence(:name) { FFaker::Product.product_name }
    sequence(:description) { FFaker::Book.description(FFaker::Random.rand(1..6)) }
    sequence(:counter) { FFaker::Random.rand(0..10) }
    sequence(:price) { FFaker::Random.rand(1.0..100.0) }

    before(:create) do |record|
      record.category = record.owner.category
      record.status = record.counter.zero? ? :pending : :available

      # Attach fake picture
      file_path = Rails.root.join('db', 'seeders', 'fixtures', 'picture.png')
      record.photo.attach(io: File.open(file_path), filename: File.basename(file_path))
    end
  end
end
