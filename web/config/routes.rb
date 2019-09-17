Rails.application.routes.draw do

  namespace :admin do
  end
  get 'pages/index'
  namespace :admin do
    get '/' => 'dashboard#index'
    get '/form' => 'dashboard#order_form'
    get 'inventory' => 'inventory#index'
    get 'orders' => 'orders#index'
    get 'orders/:id/confirm' => 'orders#confirm', as: 'order_confirm'
    post 'orders/:id/complete' => 'orders#complete', as: 'orders_complete'
    # post 'orders/edit_item'
    resources :patch_types
    resources :items
    resources :clubs
    resources :configs

    resources :orders, only: [:show]
  end

  post '/orders/:id/pay' => 'orders#pay', as: 'order_pay'
  get '/orders/:id/check' => 'orders#check', as: 'order_check'

  resources :orders


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'
end
