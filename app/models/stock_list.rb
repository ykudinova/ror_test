class StockList < ApplicationRecord
  belongs_to :user
  has_many :stock, :dependent => :delete_all
end
