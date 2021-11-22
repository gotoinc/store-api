class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, index: true, nullable: false
      t.references :product, index: true, nullable: false
      t.timestamps
    end
  end
end
