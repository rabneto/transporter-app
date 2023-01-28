Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"
  
  resources :transport_modes, only: [:index, :show, :new, :create, :edit, :update] do
    patch :desactive, on: :member
    patch :active, on: :member
  end

  resources :categories, only: [:index, :new, :create, :edit, :update] do
    patch :desactive, on: :member
    patch :active, on: :member
  end

  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update] do
    patch :desactive, on: :member
    patch :active, on: :member
  end

  resources :prices, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :deadlines, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :orders, only: [:index, :show, :new, :create, :edit, :update] 

  get "/pending/:id", to: 'orders#show_pending', as: 'order_pending'
  get "/pending", to: 'orders#pending', as: 'orders_pending'

  get "/in_delivery/:id/tm/:tm/p/:p/d/:d", to: 'orders#change_to_in_delivery'
  get "/delivered/:id", to: 'orders#change_to_delivered', as: 'order_finish'

end
