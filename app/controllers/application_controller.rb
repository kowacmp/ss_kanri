class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  #権限チェック
  #before_filter :permission_check
  
  include ApplicationHelper
  
  def after_sign_in_path_for(resources)
    session[:m_authority_id] = current_user.m_authority_id
    get_menus(current_user.m_authority_id)

    root_path
  end  
  
  #権限チェック
  def permission_check
    p "permission_check"
    p params
    p params[:menu_id]
    p current_user if current_user
    
    if params[:menu_id] and current_user
      authority_menu = AuthorityMenu.find(:first,:conditions=>["m_authority_id=? and menu_id=?", current_user.m_authority_id.to_i, params[:menu_id]])
      p "authority_menu.blank?=#{authority_menu.blank?}"
      if authority_menu.blank?
        redirect_to(url_for(:controller=>"homes", :action=>"index"))
        return
      end
    else
      if params[:menu_id].blank? and params[:controller] != "devise/sessions"
        redirect_to(url_for(:controller=>"homes", :action=>"index"))
      end
      return
    end
    return
  end
  
end
