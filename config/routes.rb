Rails.application.routes.draw do
  resources :widgets

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'welcome#index'

  get "users/", to: "users#index", :as => :users
  post "users/", to: "users#create"
  get "users/new", to: "users#new", :as => :new_user
  get "users/:id/edit", to: "users#edit", :as => :edit_user
  get "users/:id", to: "users#show", :as => :user
  patch "users/:id", to: "users#update"
  delete "users/:id", to: "users#destroy"

  get "teams/", to: "teams#index", :as => :teams
  post "teams/", to: "teams#create"
  get "teams/new", to: "teams#new", :as => :new_team
  get "teams/:id/edit", to: "teams#edit", :as => :edit_team
  get "teams/:id", to: "teams#show", :as => :team
  patch "teams/:id", to: "teams#update"
  delete "teams/:id", to: "teams#destroy"
  post "teams/:team_id/team_users", to: "team_users#create", :as => :team_users

  get "games/", to: "games#index", :as => :games
  post "games/", to: "games#create"
  get "games/new", to: "games#new", :as => :new_game
  get "games/:id/edit", to: "games#edit", :as => :edit_game
  get "games/:id", to: "games#show", :as => :game
  patch "games/:id", to: "games#update"
  delete "games/:id", to: "games#destroy"

  get "matchs/", to: "matchs#index", :as => :matches
  post "matchs/", to: "matchs#create"
  get "matchs/new", to: "matchs#new", :as => :new_match
  get "matchs/:id/edit", to: "matchs#edit", :as => :edit_match
  get "matchs/:id", to: "matchs#show", :as => :match
  patch "matchs/:id", to: "matchs#update"
  delete "matchs/:id", to: "matchs#destroy"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
