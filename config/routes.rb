Foofalo::Application.routes.draw do

  get "manster_cards/index"

  #resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets
  resources :parent_confirms
  resources :jokes  
  #resources :challenges
  resources :fun_facts
  resources :links
  resources :manster_cards

  root :to => 'static_pages#home'
  
  resources :users do
    resources :answers
  end
  resources :challenges do
    resources :answers
  end

  match '/',                 :to => 'static_pages#home'
  match '/about',            :to => 'static_pages#about'
  match '/terms',            :to => 'static_pages#terms'
  match '/index',            :to => 'static_pages#index'
  match '/signup',           :to => 'users#new'
  match '/users',            :to => 'users#index'
  match '/users',            :to => 'static_pages#home'
  match '/signin',           :to => 'sessions#new'
  match '/guest',            :to => 'sessions#guest'
  match '/signout',          :to => 'sessions#destroy'
  match '/updateuser',       :to => 'users#update_privilege'
  match '/newjoke',          :to => 'jokes#new'
  match '/jokes',            :to => 'jokes#index'
  match '/jokesshow/',       :to => 'jokes#show'
  match '/jokesauthor',      :to => 'jokes#jokes_author'
  match '/jokesdate',        :to => 'jokes#jokes_date'
  match '/myjokes',                 :to => 'jokes#my_jokes'
  match '/jokesbyauthors',          :to => 'jokes#jokes_by_authors'
  match '/usernamereminder',        :to => 'username_reminder#new'
  match '/usernamereminder_create', :to => 'username_reminder#create'
  match '/challenges',              :to => 'challenges#index'
  match '/newchallenge',            :to => 'challenges#new'
  match '/games',                   :to => 'games#index'
  match '/funfacts',                :to => 'fun_facts#index'
  match '/newfunfact',              :to => 'fun_facts#new'
  match '/links',                   :to => 'links#index'
  match '/newlink',                 :to => 'links#new'
  match '/managelinks',             :to => 'links#manage_links'
  match '/review_jokes',            :to => 'jokes#review_jokes', :method => :put
  match '/review_joke',             :to => 'jokes#review_joke', :method => :put
  # match '/unapprove',               :to => 'jokes#unapprove', :method => :put
  match '/submit_answer',           :to => 'challenges#submit_answer', :method => :put
  # match '/cancel',                  :to => 'users#cancel'
  match '/update_privilege',        :to => 'users#update_privilege', :method => :put
  match '/manstercards',            :to => 'manster_cards#index'
  
  
  #match '/saveanswer',      :to => 'answers#save_answer', :method => :put
  
 


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
