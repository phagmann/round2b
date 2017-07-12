Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "macheaders#index"
  resources :macheaders, only: [:index, :update, :show]
end
