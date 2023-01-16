Rails.application.routes.draw do
  
  root to: "home#index"
  resources :transport_modes, only: [:index, :show, :new, :create, :edit, :update] do
    patch :desactive, on: :member
    patch :active, on: :member
  end

end
