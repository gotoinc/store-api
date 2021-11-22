class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true, nullable: false
      t.references :product, index: true, nullable: false
      t.references :invoice, nullable: true
      t.integer :counter, default: 0, nullable: false
      t.timestamps
    end
  end
end
