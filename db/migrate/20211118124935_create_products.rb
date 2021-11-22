class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :status, default: 0
      t.string :uuid, unique: true
      t.string :name, nullable: false
      t.string :description
      t.decimal :price, scale: 2, precision: 10, default: 0.0
      t.integer :counter, default: 0
      t.references :user
      t.timestamps
    end
  end
end
