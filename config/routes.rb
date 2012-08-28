SsKanri::Application.routes.draw do

  resources :m_fix_items

  resources :establishes

  resources :d_tank_decrease_reports do
   collection do
     get :print
   end
  end
  #get "d_tank_decrease_reports/index"

  #get "d_tank_decrease_reports/print"

  get "d_fixture_approvals/index"
  get "d_fixture_approvals/edit"
  get "d_fixture_approvals/change_radio"

  resources :m_audit_checks

  resources :m_class_checks

  resources :m_item_accounts
  
  resources :m_approvals
  
  get "d_washsale_reports/index"

  get "d_washsale_reports/search"

  get "d_washsale_reports/update"

  get "d_washsale_report_lists/index"
  get "d_washsale_report_lists/search"
  
  get "d_washsale_lists/index"
  get "d_washsale_lists/update"
  get "d_washsale_lists/show"
  get "d_washsale_lists/compare"
  get "d_washsale_lists/search"

  get "d_wash_sales/index"
  get "d_wash_sales/index_modal"
  get "d_wash_sales/entry_error"
  get "d_wash_sales/change_input_ymd"
  get "d_wash_sales/update"

  get "d_sale_etcs/index"
  get "d_sale_etcs/entry_error"
  get "d_sale_etcs/change_input_ymd"
  get "d_sale_etcs/update"

  get "d_results/index"
  get "d_results/select_date"
  get "d_results/result_edit"

  resources :userdata do
    collection do
      get :test
    end
  end
 
  match "d_audit_changemachines/confirm_shop_id_select", :to => "d_audit_changemachines#confirm_shop_id_select"
  match "d_audit_changemachines/confirm_user_id_select", :to => "d_audit_changemachines#confirm_user_id_select"
  resources :d_audit_changemachines
 
  match "d_audit_washes/confirm_shop_id_select", :to => "d_audit_washes#confirm_shop_id_select"
  match "d_audit_washes/confirm_user_id_select", :to => "d_audit_washes#confirm_user_id_select"
  resources :d_audit_washes
  
  match "d_audit_etcs/confirm_shop_id_select", :to => "d_audit_etcs#confirm_shop_id_select"
  match "d_audit_etcs/confirm_user_id_select", :to => "d_audit_etcs#confirm_user_id_select"
  resources :d_audit_etcs
 
  resources :m_shop_groups
  
  resources :d_aims

  resources :m_aims

  resources :m_meters
 
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

  resources :m_items

  resources :d_sale_items

  resources :d_sales do
    collection do
      delete :destroy_d_sale_item
      get :lock
      get :all_lock
      get :report_view
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
