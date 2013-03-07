SampleApp::Application.routes.draw do
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

  resources :news do
    match 'new_comment', :to => 'news#create_comment'
  end
  resources :articles do
    match 'new_comment', :to => 'articles#create_comment'
  end

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  namespace :admin do
    resources :roles
    resources :tags
    match "tags_search", :to => "tags#tags_for_autocomplete"
    resources :users, :only => :index
    resources :arts
    resources :art_subcategories
  end

  resources :arts, :only=> :index

  match '/join_confirm', :to => 'sessions#join_confirm'
end
