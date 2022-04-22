Rails.application.routes.draw do

  resources :items
  #resources :brands
  resources :categories
  resources :admins
  resources :orders do
  resources :orderitems
  end

  #security permissions for users
  devise_for :admin do
    resources:orders.all
  end

  #admin rule
  get '/makeadmin/:id' => 'static_pages#makeadmin'
  get '/removeadmin/:id' => 'static_pages#removeadmin'

  devise_for :users do
    resources:orders
  end

  root 'static_pages#home'
  #root :to => 'site#home'

  get '/items' => 'items#index'
  
  #cart section
  get '/checkout' => 'cart#createOrder'
  get 'cart/index'
  get '/cart' => 'cart#index'
  #get 'cart/index'
  get '/cart/:id' => 'cart#add'
  get '/clearcart' => 'cart#clearcart'
  get '/remove/:id' => 'cart#remove'
  get '/decrease/:id' => 'cart#decrease'
  get '/increase/:id' => 'cart#increase'
  get '/paid/:id' => 'static_pages#paid'
  get '/done' => 'cart#done'

  get '/admin' => 'static_pages#admincontrol'

  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get '/returns' => 'static_pages#returns'
  #get '/brands' => 'static_pages#brands'
  get '/category' => 'static_pages#category'
  get '/category/:cat_name' => 'static_pages#category'

  post '/search' => 'items#search'
  get '/search' => 'static_pages#search'
  get '/search/:title' => 'static_pages#search'

  get '/collections' => 'static_pages#collections'

end