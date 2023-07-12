class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.boolean :active, default: false
      t.boolean :system, default: false
      t.string :type, null: false
      t.decimal :discount, null: false
      t.integer :discount_type, null: false
      t.text :rule
      t.timestamps
    end
  end
end
