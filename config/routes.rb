SsKanri::Application.routes.draw do


  get "data_deletes/index"
  get "data_deletes/edit"

  resources :m_keep_months

  get "d_duty_outputs/index"
  
  get "d_price_check_reports/index"
  get "d_price_check_reports/search"
  get "d_price_check_reports/print"

  get "m_price_chk_names/index"

  resources :m_cost_names

  get "d_duty_lists/index"
  get "d_duty_lists/search"

  get "d_duty_reports/index"

  get "d_duty_reports/show"
  post "d_duty_reports/comment_add"
  get "d_duty_reports/print"

  resources :m_machine_numbers

  resources :access_logs

  get "d_sale_etc_lists/index"
  get "d_sale_etc_lists/update"
  get "d_sale_etc_lists/search"

  get "postgre_sql_maintenances/index"
  get "postgre_sql_maintenances/sequence"
  get "postgre_sql_maintenances/seq_update"


  get "d_result_oil_lists/index"

  get "d_result_oil_lists/csv"

  get "d_result_tank_lists/index"

  get "d_result_tank_lists/csv"

  get "d_audit_cashboxes/index"
  get "d_audit_cashboxes/edit"
  get "d_audit_cashboxes/show"
  get "d_audit_cashboxes/update"
  get "d_audit_cashboxes/edit_tbl1"
  get "d_audit_cashboxes/edit_tbl2"
  get "d_audit_cashboxes/update_tbl1"
  get "d_audit_cashboxes/update_tbl2"
  get "d_audit_cashboxes/edit_comment"

  resources :m_get_points

  get "d_price_check_etcs/index"
  get "d_price_check_etcs/search"
  get "d_price_check_etcs/edit"
  get "d_price_check_etcs/update"  
  get "d_price_check_etcs/show"

  resources :d_duties do
   collection do
     get :syain_input
     post :syain_input_add
     get :baito_input
     post :baito_input_add
     get :syain_row_input
     post :syain_row_input_add
     get :baito_row_input
     post :baito_row_input_add
     get :input_check
     get :kakutei_check
     post :all_input_flg_update
   end
  end

  get "d_aim_lists/index"
  get "d_aim_lists/search"

  resources :m_etc_shops

  get "d_price_checks/index"

  get "d_washpurika_reports/index"
  get "d_washpurika_reports/edit"
  get "d_washpurika_reports/show"
  get "d_washpurika_reports/print"

  resources :d_result_reports do
   collection do
     get :print
   end
  end

  get "d_business_count_reports/index"

  get "d_business_count_reports/search"

  get "d_business_count_reports/print"
  get "d_yume_point_lists/index"
  get "d_yume_point_lists/search"
  get "d_yume_point_lists/print"

  get "d_sale_approves/index"
  get "d_sale_approves/edit"

  get "d_tank_compute_report_details/index"
  get "d_tank_compute_report_details/search"
  get "d_tank_compute_report_details/print"
  get "d_tank_compute_report_details/change_oil"

  get "d_tank_compute_reports/index"
  get "d_tank_compute_reports/search"

  get "d_audit_checks/edit"
  
  get "d_sale_report_lists/index"
  
  resources :d_audit_checks

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
  get "d_results/index_select"
  get "d_results/d_resit_meter_reload"
  
  get "d_audit_changemachines/confirm_shop_id_select"
  get "d_audit_changemachines/confirm_user_id_select"
  get "d_audit_changemachines/show"
  get "d_audit_changemachines/edit"
  get "d_audit_changemachines/index"
  
  get "d_audit_washes/edit"
  get "d_audit_washes/index"

  get "d_audit_etcs/show"  
  get "d_audit_etcs/edit"
  get "d_audit_etcs/index"
 
  resources :m_shop_groups
  
  resources :d_aims

  resources :m_aims

  resources :m_meters
 
  resources :m_washsale_plans

  resources :m_tanks

  resources :m_shops

  resources :m_codes

  resources :m_info_costs do
   collection do
     get :popup_edit
     post :popup_update
   end
  end
  
  resources :m_etcsales

  resources :m_washes

  resources :m_etcs

  resources :m_oiletcs

  resources :m_oils

  resources :d_comments do
    collection do
      get :change_m_shop
    end
  end

  resources :d_events

  devise_for :users, :path_names => { :sign_up => "register" }

  resources :m_authorities

  resources :authority_menus do
    collection do
      get :authority_select
    end
  end
  
  resources :menus

  resources :m_items

  resources :d_sale_items

  resources :d_sales do
    collection do
      delete :destroy_d_sale_item
      get :lock
      get :all_lock
      get :report_view
      get :report_print
      get :comment
      post :comment_update
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

  resources :users

#devise_for :users, :path => "usuarios", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }


#  resources :tasks, :only => [ :index, :create ] do  
#    put :finish, :on => :member  
#    put :unfinish, :on => :member  
#    get :done, :on => :collection  
#  end    
end
