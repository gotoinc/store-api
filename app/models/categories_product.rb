# == Schema Information
#
# Table name: categories_products
#
#  id          :bigint           not null, primary key
#  category_id :bigint
#  product_id  :bigint
#
# Indexes
#
#  index_categories_products_on_category_id                 (category_id)
#  index_categories_products_on_category_id_and_product_id  (category_id,product_id)
#  index_categories_products_on_product_id                  (product_id)
#  index_categories_products_on_product_id_and_category_id  (product_id,category_id)
#
class CategoriesProduct < ApplicationRecord

  # Relations
  belongs_to :category
  belongs_to :product
end
