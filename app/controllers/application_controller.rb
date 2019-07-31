class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #GetPricesJob.set(wait: 5.minute).perform_later()
  GetPricesJob.perform_now()
end
