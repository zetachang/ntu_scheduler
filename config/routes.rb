NtuScheduler::Application.routes.draw do
  
  resources :users, :only => [:create]
  resources :schedule_sets, :only => [:index, :destroy, :show] do
    post 'create_when_compare', :on => :collection
  end
  get 'welcome/tutorial' => 'welcome#show_tutorial', :as => 'show_tutorial'
  get 'schedules/show_friend' => 'schedules#show_friend', :as => 'show_friend'
  get 'schedules/show_self' => 'schedules#show_self', :as => 'show_self'
  get 'schedules/:id' => 'schedules#show', :as => "schedule"
  post 'schedules/compare_me/:id' => 'schedules#compare_me', :as => 'compare_with_me'
  get 'main/friends' => 'main#friends'
  get 'main/firends_index' => 'main#friends_index', :as => 'friends_index'
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
  root :to => 'welcome#index'
  # TODO: it's just for test!
  get "tests/display", :as => "test_me"
  get "main" => "main#index", :as => :main
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
