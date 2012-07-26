class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
    include ApplicationHelper
  def after_sign_in_path_for(resources)
    #bookmark_path
    p "after_sign_in_path_for   after_sign_in_path_for   after_sign_in_path_for   after_sign_in_path_for"
    p "params=#{params}"
    p current_user.m_authority_id
   session[:m_authority_id] = current_user.m_authority_id
    get_parent_menu(current_user.m_authority_id)

    root_path
  end  
end
