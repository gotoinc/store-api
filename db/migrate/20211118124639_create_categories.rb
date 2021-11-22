class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, nullable: false
      t.timestamps
    end
  end
end
