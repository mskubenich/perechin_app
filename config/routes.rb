SampleApp::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root :to => 'pages#home'

  resources :users
  match '/sign_up',  :to => 'users#new'
  post '/users/change_name', :to => "users#change_name"
  post '/users/change_password', :to => "users#change_password"
  post '/users/change_avatar', :to => "users#change_avatar"
  post '/users/change_about_me', :to => "users#change_about_me"

  #resources :sessions, :only => [:new, :create, :destroy]
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/sessions', :to => 'sessions#create'
  match '/join_confirm', :to => 'sessions#join_confirm'

  resources :news do
    match 'new_comment', :to => 'news#create_comment'
  end
  resources :articles do
    match 'new_comment', :to => 'articles#create_comment'
  end
  resources :arts do
    post 'new_comment', :to => 'arts#create_comment'
  end
  post '/arts/subcategories_for_category', :to => "arts#subcategories_for_category"

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  namespace :admin do
    get '/index', :to => 'pages#index'
    resources :roles
    resources :tags
    match "tags_search", :to => "tags#tags_for_autocomplete"
    resources :users, :only => :index
    post '/users/change_user_role', :to => "users#change_user_role"
    resources :arts
    post '/arts/approve_work', :to => "arts#approve_work"
    resources :art_subcategories
    resources :populated_places, :except => :show
    resources :places_categories, :except => :show
  end

  resources :maps, :only => :index
  get '/maps/populated_place/:id', :to => "maps#populated_place", :as => 'maps_populated_place'
  get '/maps/showplace/:id', :to => "maps#showplace", :as => 'maps_showplace'
  get '/maps/new_showplace', :to => "maps#new_showplace"
  post '/maps/create_showplace', :to => "maps#create_showplace"
  get '/maps/edit_showplace/:id', :to => "maps#edit_showplace", :as => 'maps_edit_showplace'
  put '/maps/update_showplace/:id', :to => "maps#update_showplace", :as => 'maps_update_showplace'
  delete '/maps/destroy_showplace/:id', :to => "maps#destroy_showplace", :as => 'maps_destroy_showplace'

  resources :anecdotes, :except => :show

  mount Ckeditor::Engine => "/ckeditor"

end
