EcoIncubators::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  namespace :admin do |admin|
    resources :users
    resources :pages
    resources :categories
  end  

end
