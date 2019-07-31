class GetPricesJob < ApplicationJob
  queue_as :default

  def perform(*args)

    key = 'A0FUVVLFSCVK26JB'

    users = User.all


    users.each do |user|
      lists = StockList.all.where(user_id: user.id)
      lists.each do |list|
        stocks = Stock.all.where(stock_list_id: list.id)
        stocks.each do |stock|
          url = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol='+stock.symbol+'&apikey='+key
          uri = URI(url)
          response = JSON.parse(Net::HTTP.get(uri))

          if(response)
            record = Record.new
            if(response['Global Quote'])
              record.date = DateTime.now
              record.price = response['Global Quote']['05. price']
              record.note = ''
              record.stock_id = stock.id
            elsif(response['Note'])
              record.date = DateTime.now
              record.price = 0.0
              record.note = response['Note']
              record.stock_id = stock.id
            else
              record.date = DateTime.now
              record.price = 0.0
              record.note = 'Unexpected response from Alpha Vantage'
              record.stock_id = stock.id
            end
            record.save
          end

        end
      end
    end
  end
  #GetPricesJob.set(wait: 2.minute).perform_later()

end
