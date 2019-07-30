class Stock < ApplicationRecord
    belongs_to :user
    belongs_to :stock_list
    has_many :record, :dependent => :delete_all
end
