desc "tweets to twitter.com/blockwork_cc"
task update_stock_prices: :environment do
  puts "Updating stock prices"
  GetPricesJob.perform_now()
  puts "prices retrieved"
end