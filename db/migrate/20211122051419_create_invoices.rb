class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.references :cart, index: true
      t.string :address
      t.decimal :total_price, scale: 2, precision: 10, default: 0.0
      t.timestamps
    end
  end
end
