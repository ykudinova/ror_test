class CreateStockLists < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_lists do |t|
      t.string :name, null: false
      t.belongs_to :user, foreign_key: true, on_delete: :cascade, on_update: :cascade

      t.timestamps
    end
  end
end
