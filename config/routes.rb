Rails.application.routes.draw do
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'pages/show'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
