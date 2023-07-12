class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, null: false
      t.decimal :tax_percentage, default: 0

      t.timestamps
    end
  end
end
