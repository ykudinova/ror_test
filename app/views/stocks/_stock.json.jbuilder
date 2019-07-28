json.extract! stock, :id, :symbol, :user_id, :price, :retrieved, :notes, :created_at, :updated_at
json.url stock_url(stock, format: :json)
