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

end
