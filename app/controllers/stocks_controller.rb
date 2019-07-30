class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy, :show]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all.where(user_id: current_user.id)
    @stock_lists = StockList.all.where(user_id: current_user.id)

    GetPricesJob.perform_now

  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @records = Record.all.where(stock_id: @stock.id).reverse
  end

  # GET /stocks/new
  def new
    @symbol = params['symb']
    @stock_list_id = params['list']

    key = '6XKJ0JAWIHVMSEKA'
    @url = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol='+@symbol+'&apikey='+key
    @uri = URI(@url)
    @response = JSON.parse(Net::HTTP.get(@uri))
    
    if(@response['Global Quote'])
      @price = @response['Global Quote']['05. price']
      @notes = ''
    else
      @price = '0.00'
      if(@response['Note'])
        @notes = @response['Note']
      else
        @notes = 'Failed to get price'
      end
    end

    if(@price)
      @price = '%.2f' % @price.to_f
    else
      @price = '0.00'
    end

    @stock = Stock.new

  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)
    respond_to do |format|
      if @stock.save
        record = Record.new
        record.price = @stock[:price]
        record.stock_id = @stock[:id]
        record.note = @stock[:notes]
        record.date = @stock[:retrieved]
        record.save
        format.html { redirect_to stocks_path, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: stocks_path }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:symbol, :user_id, :price, :retrieved, :notes, :stock_list_id, :stockList)
    end

    def correct_user
      @correct = current_user.stock.find_by(id: params[:id])
      redirect_to stocks_path, notice: "Not Autherized to edit this entry" if @correct.nil?
    end
end
