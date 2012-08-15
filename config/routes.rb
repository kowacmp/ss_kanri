SsKanri::Application.routes.draw do
  get "d_wash_sales/index"
  get "d_wash_sales/entry_error"
  get "d_wash_sales/change_input_ymd"
  get "d_wash_sales/create"
  get "d_wash_sales/update"
      
  get "d_results/index"

  resources :userdata do
    collection do
      get :test
    end
  end


  resources :m_washsale_plans

  resources :m_tanks

  resources :m_shops

  resources :m_codes

  resources :m_info_costs

  resources :m_etcsales

  resources :m_washes

  resources :m_etcs

  resources :m_oiletcs

  resources :m_oils

  resources :d_comments

  resources :d_events

  devise_for :users, :path_names => { :sign_up => "register" }

  resources :m_authorities

  resources :authority_menus do
    collection do
      get :authority_select
    end
  end
  
  resources :menus do
    collection do
      get :city_select  
      get :test   
    end
  end

  get "homes/index"

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
  # root :to => 'homes#index'
  match ':controller(/:action(/:id(.:format)))'
  
  root :to => 'homes#index'
  
  devise_for :users  
  get 'homes', :to => 'homes#index', :as => :user_root  

#devise_for :users, :path => "usuarios", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }


#  resources :tasks, :only => [ :index, :create ] do  
#    put :finish, :on => :member  
#    put :unfinish, :on => :member  
#    get :done, :on => :collection  
#  end    
end
