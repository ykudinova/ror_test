class Stock < ApplicationRecord
    belongs_to :user
    belongs_to :stock_list
end
