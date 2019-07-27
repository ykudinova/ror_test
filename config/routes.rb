Rails.application.routes.draw do
  get 'welcome/lookup'
  post 'welcome/lookup'=>'welcome/lookup'
  root 'welcome#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
