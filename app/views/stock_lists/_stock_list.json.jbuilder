json.extract! stock_list, :id, :name, :user_id, :created_at, :updated_at
json.url stock_list_url(stock_list, format: :json)
