class AddListKeyToStocks < ActiveRecord::Migration[5.1]
  def change
    # add_column :stocks, :stock_list_id, :integer, default: 0, null: false
    # add_foreign_key :stocks, :stock_lists, column: :stock_list_id, primary_key: "id", on_delete: :cascade, on_update: :cascade
    # add_foreign_key :stocks, :stock_lists
    add_reference :stocks, :stock_list, foreign_key: true, on_delete: :cascade, on_update: :cascade
  end
end
