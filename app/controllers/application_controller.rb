class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  include ApplicationHelper
  
  def after_sign_in_path_for(resources)
    session[:m_authority_id] = current_user.m_authority_id
    get_menus(current_user.m_authority_id)

    root_path
  end  
end
