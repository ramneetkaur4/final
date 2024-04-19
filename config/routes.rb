Rails.application.routes.draw do
  get 'about_pages/show'
  get 'contact_pages/show'
  get 'shopping_cart/show'
  get 'search/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users

  # ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :reviews, only: [:index, :show]
  resources :orders
  get '/invoice/:id', to: 'orders#invoice', as: 'invoice'
  # resources :order_items, only: [:index, :show]
  resources :contacts, only: [:show]
  resources :abouts, only: [:show]
  resources :search, only: :index
  resources :cart_items, only: [:create, :update, :destroy]
  resources :about_pages, only: [:show]
  resources :contact_pages, only: [:show]
  resources :users, only: [:index]
  resources :payments, only: [:create, :new]

  resources :users, only: [:new, :create, :show] # Remove the duplicate entry for :users
  root to: 'products#index'

  # Route for removing a product from the cart (DELETE request)
  delete 'cart/remove_from_cart', to: 'carts#remove_from_cart', as: :remove_from_cart

  # Route for updating the quantity of a product in the cart (POST request)
  post 'cart/update_quantity', to: 'carts#update_quantity', as: :update_quantity
  resource :cart, only: [:show] do
    post 'add_to_cart', on: :member
    # post 'update_quantity', on: :collection
    # post 'increase_quantity', on: :collection
    # post 'decrease_quantity', on: :collection
    # post 'remove_from_cart', on: :member
  end
  post '/orders/:id',  to: 'orders#update', as: "order_item"

  get '/dashboard', to: 'dashboard#index'
  get 'search', to: 'search#index', as: 'search'
  # devise_scope :user do
  #   get '/sign_out', to: 'devise/sessions#destroy', as: 'signout'
  # end
  post '/orders/:id',  to: 'orders#create', as: "order_items"
  get '/orders/checkout/:id', to: 'orders#checkout', as: "checkout"
  get '/order/placed', to: 'orders#order_successful', as: "order_successful"
end
