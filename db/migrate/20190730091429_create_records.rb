class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.datetime :date
      t.float :price
      t.text :note
      t.references :stock, foreign_key: { on_delete: :cascade, on_update: :cascade }
      #t.add_reference :stocks, :stock_list, foreign_key: true, on_delete: :cascade, on_update: :cascade

      t.timestamps
    end
  end
end
