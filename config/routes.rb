Rails.application.routes.draw do
  resources :places
  get 'boards/index'

  get 'boards/show'

  resources :places , only: [:create , :destroy ] do
    resources :messages
  end

  post 'boards/create' => 'boards#create'


  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'pages/show'


  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
