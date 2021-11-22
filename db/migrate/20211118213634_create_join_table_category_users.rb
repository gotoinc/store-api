class CreateJoinTableCategoryUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :category_users do |t|
      t.references :category
      t.references :user

      t.index [:category_id, :user_id]
      t.index [:user_id, :category_id]

      t.timestamps
    end
  end
end
