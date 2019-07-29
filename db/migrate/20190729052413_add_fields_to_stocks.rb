class AddFieldsToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :stockList, :string, default: 0, null: false
  end
end
