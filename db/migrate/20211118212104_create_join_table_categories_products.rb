class CreateJoinTableCategoriesProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :categories_products do |t|
      t.references :category
      t.references :product

      t.index [:category_id, :product_id]
      t.index [:product_id, :category_id]
    end
  end
end
