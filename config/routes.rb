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

  resources :pages, :only => [:index, :show]
  resources :products, :only => [:index, :show]
  match 'admin' => "admin/pages#index",     :as => :admin_dashboard
  match 'contact-us' => 'pages#contact_us', :as => :contact_us
  match 'about-us'   => 'pages#about_us',   :as => :about_us
  
end
