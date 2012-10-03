class ApplicationController < ActionController::Base
  clear_helpers
  protect_from_forgery
  before_filter :authenticate_user!
  
  #権限チェック
  before_filter :permission_check
  
  include ApplicationHelper
  
  def after_sign_in_path_for(resources)
    session[:m_authority_id] = current_user.m_authority_id
    get_menus(current_user.m_authority_id)

    root_path
  end  
  
  #権限チェック
  def permission_check
    
    p "****** permission_check ******"
    p "** path=#{request.headers['ORIGINAL_FULLPATH']}"
    p "** method=#{request.headers['REQUEST_METHOD']}"
    p "** controller=#{params[:controller]}"
    p "** action=#{params[:action]}"
    p "******************************"
    
    return if params[:controller].index('devise') != nil
    return unless request.headers['REQUEST_METHOD'] == "GET" #メソッドがget以外はチェックしない
    return if current_user.blank?
    
    select_sql = "select a.* from menus a inner join authority_menus b on a.id = b.menu_id "
    select_sql << " where b.m_authority_id = #{current_user.m_authority_id.to_i} "
    select_sql << " and (a.uri like '#{params[:controller]}%' or a.permission_actions like '%#{params[:controller]}/%')"
    p "select_sql=#{select_sql}"
    menus = Menu.find_by_sql(select_sql)
   
    if menus[0].blank?
      #レコードを取得できなければホーム画面へ
      p "permission NG!! #{request.headers['ORIGINAL_FULLPATH']}"
      redirect_to(url_for(:controller=>"homes", :action=>"index"))
      return
    else
      #取得したデータでコントローラ名で完全一致する場合は、OK
      for menu in menus
        #p "menu.uri=#{menu.uri}"
        #p "params[:controller]=#{params[:controller]}"
        
        #登録されているアクションがない場合は、全てOK
        if menu.permission_actions.blank?
          p "permission ok #{request.headers['ORIGINAL_FULLPATH']}"
          return
        end        
        
        #
        array_permission_actions = menu.permission_actions.split(",")
        p "array_permission_actions=#{array_permission_actions}"
        array_permission_actions.each_with_index{|value, i|
          
          if value.include?("/")
            control = value[0..value.index("/")-1]
            action = value[value.index("/")+1..value.length]
          else
            control = params[:controller]
            action = value
          end
          
          p "permission_action=#{action}"
          p "control=#{control}"
          #使用を許可したアクションにパラメータが指定されている場合はそのパラメータまでで許可できるか判断する
          if  action.include?("?")
            #パラメータが含まれている場合
            #まず、アクションを判断
            if params[:action] == action[0..action.index("?")-1]
               
               #リクエストされたURLからパラメータのみ抽出
               path = request.headers['ORIGINAL_FULLPATH']
               inp_parms = path[path.index("?").to_i..path.length]
               inp_parms = inp_parms.sub("?","")
               
               #許可するパラメータを取得
               permission_params = action[action.index("?").to_i..action.length]
               permission_params = permission_params.sub("?","")
               
               #チェックするパラメータを配列にする
               inp_parms_array = inp_parms.split("&")
               permission_params_array = permission_params.split("&")
               permission_ok = true
               
               #指定されたパラメータが含まれているがチェック
               permission_params_array.each{|permission_value|
                  if inp_parms_array.index(permission_value) != nil and params[:controller] == control
                  else
                    permission_ok = false
                    break
                  end                  
               }
               if permission_ok
                 p "permission ok #{request.headers['ORIGINAL_FULLPATH']}"
                 return
               end
            end
          else
            if params[:controller] == control and params[:action] == action 
              p "permission ok #{request.headers['ORIGINAL_FULLPATH']}"
              return
            end
          end
        }

      end
      #ここにきたら使用権限がないのでHOMEへ
      p "permission NG!! #{request.headers['ORIGINAL_FULLPATH']}"
      redirect_to(url_for(:controller=>"homes", :action=>"index"))
    end
  
  end
  
end
