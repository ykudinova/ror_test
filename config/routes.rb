Rails.application.routes.draw do
  resources :stock_lists
  resources :stocks
  get 'welcome/lookup'
  post 'welcome/lookup'=>'welcome/lookup'
  root 'stocks#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
