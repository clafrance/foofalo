Foofalo::Application.routes.draw do

  get "manster_cards/index"

  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets
  resources :parent_confirms
  resources :jokes  
  resources :fun_facts
  resources :links
  resources :games
  resources :manster_cards  
  resources :users do
    resources :answers
  end
  resources :challenges do
    resources :answers
  end

  root                              :to => 'static_pages#home'
  match '/',                        :to => 'static_pages#home'
  match '/about',                   :to => 'static_pages#about'
  match '/terms',                   :to => 'static_pages#terms'
  match '/index',                   :to => 'static_pages#index'
  
  match '/guest',                   :to => 'sessions#guest'
  match '/signout',                 :to => 'sessions#destroy'
  match '/updateuser',              :to => 'users#update_privilege'
  match '/usernamereminder',        :to => 'username_reminder#new'
  match '/usernamereminder_create', :to => 'username_reminder#create'
  
  match '/jokesauthor',             :to => 'jokes#jokes_author'
  match '/jokesdate',               :to => 'jokes#jokes_date'
  match '/myjokes',                 :to => 'jokes#my_jokes'
  match '/jokesbyauthors',          :to => 'jokes#jokes_by_authors'
  match '/review_jokes',            :to => 'jokes#review_jokes', :method => :put
  match '/review_joke',             :to => 'jokes#review_joke', :method => :put

  match '/managelinks',             :to => 'links#manage_links'

  # match '/unapprove',               :to => 'jokes#unapprove', :method => :put
  match '/submit_answer',           :to => 'challenges#submit_answer', :method => :put
  # match '/cancel',                  :to => 'users#cancel'
  match '/update_privilege',        :to => 'users#update_privilege', :method => :put
end
