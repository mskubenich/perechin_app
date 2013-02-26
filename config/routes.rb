SampleApp::Application.routes.draw do
  root :to => 'pages#home'

  resources :users
  match '/sign_up',  :to => 'users#new'

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
    resources :art
  end

  resources :art, :only=> :index

  match '/join_confirm', :to => 'sessions#join_confirm'
end
