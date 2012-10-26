# -*- coding:utf-8 -*-
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  skip_before_filter :permission_check, :only => ['edit', 'update']
  
  def index
    #@users = User.all
    #@users = User.find(:all,:order=>"id")
    
    select_sql = "select a.*, b.shop_name,"
    select_sql << "           c.code_name as user_class_name, " 
    select_sql << "           d.authority_name, " 
    select_sql << "           e.code_name as salary_kbn_name " 
    select_sql << " from users a " 
    select_sql << " left join (select * from m_shops) b on a.m_shop_id = b.id "
    select_sql << " left join (select * from m_codes where kbn='user_class') c on a.user_class = cast(c.code as integer) "
    select_sql << " left join (select * from m_authorities) d on a.m_authority_id = d.id "
    select_sql << " left join (select * from m_codes where kbn='salary_kbn') e on a.salary_kbn = cast(e.code as integer) "
    
    condition_sql = ""
    
    
    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where a.deleted_flg = 0 "
        @users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.account")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where a.deleted_flg = 0 "
          @users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.account")
        else
          @users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.account")
        end
    end
    
    #@users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    
    @pass_flg = params[:pass_flg].to_i
    @return_flg = params[:return_flg].to_i
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    
    @user.password = params[:user][:account]
    @user.password_confirmation = params[:user][:account]

    respond_to do |format|
      if @user.save
        format.html { redirect_to :controller => "users", :action => "index" }
        #format.html { redirect_to @user, notice: 'Establish was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @pass_flg = params[:pass_flg].to_i
    @return_flg = params[:return_flg].to_i

    if @pass_flg == 1
      if @user.valid_password?(params[:user][:password])
        @user.errors[:base] = "前回とパスワードが同じです。"
      end
      
      unless params[:user][:password] == nil
        if params[:user][:password].length < 4 or params[:user][:password].length > 40
           @user.errors[:base] = "パスワードは４文字以上４０文字以内で入力してください。"
        end
      end
    end

    respond_to do |format|
      
      if @user.errors.count > 0
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        if @user.update_attributes(params[:user])
          input_check = params[:input][:check].to_i
          format.html { redirect_to :controller => "users", :action => "index",:input_check => input_check }
          #format.html { redirect_to :controller => "users", :action => "index" }
          #format.html { redirect_to @establish, notice: 'Establish was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    #@user.destroy
    if @user.deleted_flg == 1
      #@user.update_attributes(:deleted_flg => 0)
      @user.deleted_flg = 0
      @user.save
    else
      #@user.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
      @user.deleted_flg = 1
      @user.deleted_at = Time.current
      @user.save
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "users", :action => "index", :input_check => input_check }
      #format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  
  def search 
    
    select_sql = "select a.*, b.shop_name,"
    select_sql << "           c.code_name as user_class_name, " 
    select_sql << "           d.authority_name, " 
    select_sql << "           e.code_name as salary_kbn_name " 
    select_sql << " from users a " 
    select_sql << " left join (select * from m_shops) b on a.m_shop_id = b.id "
    select_sql << " left join (select * from m_codes where kbn='user_class') c on a.user_class = cast(c.code as integer) "
    select_sql << " left join (select * from m_authorities) d on a.m_authority_id = d.id "
    select_sql << " left join (select * from m_codes where kbn='salary_kbn') e on a.salary_kbn = cast(e.code as integer) "
    
    condition_sql = ""
    
    if params[:select][:shop_id] != ""
      condition_sql = " where a.m_shop_id = " + params[:select][:shop_id]
    end
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.account")
    else
      @check_del_flg = 0
      if condition_sql == ""
        condition_sql = " where a.deleted_flg = 0 "
      else
        condition_sql = condition_sql + " and a.deleted_flg = 0 "
      end
      @users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.account")
    end
    
    #@users = User.find_by_sql("#{select_sql} #{condition_sql} order by a.id")

  end

  def change_m_shop
    p "change_m_shop   change_m_shop   change_m_shop   change_m_shop"
  end

end
