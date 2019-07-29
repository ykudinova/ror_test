class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
    require 'net/http'
    require 'json'

    api_keys=['6XKJ0JAWIHVMSEKA', '2JFWTOO6JJ3BXLT6', 'NZM17HTRUV4KHRSM', 'AXGWYWZE0PO2FXIX', 'A0FUVVLFSCVK26JB' ]
    stock_symbols = ['GOOG', 'AAPL', 'FB', 'AMZN', 'NFLX']

    symb_pairs = {
      api_keys[0] => stock_symbols[0],
      api_keys[1] => stock_symbols[1],
      api_keys[2] => stock_symbols[2],
      api_keys[3] => stock_symbols[3],
      api_keys[4] => stock_symbols[4],
    }

    @ticks = []
    symb_pairs.each do |key, symb|
      @url = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol='+symb+'&apikey='+key
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      if(@response['Global Quote'])
        @ticks.push(JSON.parse(@response))
      else
        json_error = {
          "Global Quote"=> {
              "01. symbol"=> symb,
              "02. api key"=> key,
              "03. error"=> Net::HTTP.get(@uri),
            }
          }
        @ticks.push(json_error)
      end
    end
  end

  def lookup
    
    @list_id = params[:list_id]

    @sym_search = params[:sym]
    if @sym_search
      @sym_search = @sym_search.upcase
    else
      @sym_search = "GOOG"
    end


    api_key = 'MD1SOBYGOXSKBWG2'
    @url = 'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords='+@sym_search+'&apikey='+api_key
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @result = JSON.parse(@response)

  end

end
