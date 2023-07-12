class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.decimal :item_total, default: 0
      t.decimal :tax_amount, default: 0
      t.decimal :promotional_amount, default: 0
      t.decimal :final_amount, default: 0

      t.timestamps
    end
  end
end
