class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :user_id
      t.decimal :price
      t.datetime :retrieved
      t.text :notes

      t.timestamps
    end
    add_index :stocks, :user_id
  end
end
