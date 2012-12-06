class MInfoCostsController < ApplicationController
  # GET /m_info_costs
  # GET /m_info_costs.json
#  def index
#    #@m_info_costs = MInfoCost.all
#    #@m_info_costs = MInfoCost.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'user_id')
#
#    select_sql = "select a.*, b.user_name "
#    select_sql << " from m_info_costs a " 
#    select_sql << " left join (select * from users) b on a.user_id = b.id "
#    
#    condition_sql = ""
#
#    if params[:input_check] == nil
#        @check_del_flg = 0
#        condition_sql = " where a.deleted_flg = 0 "
#        @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql} order by b.account")
#    else
#        @check_del_flg = params[:input_check].to_i
#        if @check_del_flg == 0
#          condition_sql = " where a.deleted_flg = 0 "
#          @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql} order by b.account")
#        else
#          @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql} order by b.account")
#        end
#    end


#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @m_info_costs }
#    end
#  end

  # GET /m_info_costs/1
  # GET /m_info_costs/1.json
 # def show
 #   @m_info_cost = MInfoCost.find(params[:id])
    
 #   select_sql = "select a.*, b.user_name "
 #   select_sql << " from m_info_costs a " 
 #   select_sql << " left join (select * from users) b on a.user_id = b.id "
    
 #   condition_sql = " where a.id = " + params[:id]
    
 #   @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql}")
    
#    @m_info_cost = @m_info_costs[0]

#    @check_del_flg = params[:input_check].to_i
    

 #   respond_to do |format|
 #     format.html # show.html.erb
 #     format.json { render json: @m_info_cost }
 #   end
 # end

  # GET /m_info_costs/new
  # GET /m_info_costs/new.json
#  def new
#    @m_info_cost = MInfoCost.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @m_info_cost }
#    end
#  end

  # GET /m_info_costs/1/edit
#  def edit
#    @m_info_cost = MInfoCost.find(params[:id])
    
#    @check_del_flg = params[:input_check].to_i
#  end

  #ポップアップ用
  def popup_edit
    @input_day = params[:input_day]
    
    @m_cost_name = MCostName.find(:first, :conditions=>["m_shop_id = ? and deleted_flg = 0", params[:m_shop_id]])
    @m_cost_name = MCostName.new if @m_cost_name.blank?
      
    @user = User.find(params[:user_id])
    
    #入社年月からの経過年月を求める
    input_y = params[:input_day].to_s[0,4].to_i
    input_m = params[:input_day].to_s[4,2].to_i
    #2012/12/06 入社年月日属性変更対応
    #nyusya_y = @user.nyusya_date.localtime.strftime("%Y").to_i
    #nyusya_m = @user.nyusya_date.localtime.strftime("%m").to_i
    nyusya_y = @user.nyusya_date[0,4].to_i
    nyusya_m = @user.nyusya_date[4,2].to_i
    
    if input_m < nyusya_m
      @keika_m = 12 - nyusya_m + input_m
      input_y = input_y - 1
    else
      @keika_m = input_m - nyusya_m
    end
    @keika_y = input_y - nyusya_y
    
    @m_info_cost = MInfoCost.find(:first, :conditions=>["user_id=?", params[:user_id]])
    if @m_info_cost.blank?
      @m_info_cost = MInfoCost.new
      @m_info_cost.user_id = params[:user_id]
    end
    
    render :layout => 'modal'
  end
    
  # POST /m_info_costs
  # POST /m_info_costs.json
#  def create
#    @m_info_cost = MInfoCost.new(params[:m_info_cost])

#    respond_to do |format|
#      if @m_info_cost.save
#        #format.html { redirect_to @m_info_cost, notice: 'M info cost was successfully created.' }
#        format.html { redirect_to @m_info_cost }
#        format.json { render json: @m_info_cost, status: :created, location: @m_info_cost }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @m_info_cost.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # PUT /m_info_costs/1
  # PUT /m_info_costs/1.json
 # def update
 #   @m_info_cost = MInfoCost.find(params[:id])

 #   respond_to do |format|
 #     if @m_info_cost.update_attributes(params[:m_info_cost])
 #       input_check = params[:input][:check].to_i
 #       format.html { redirect_to :controller => "m_info_costs", :action => "show",:id=>@m_info_cost.id,:input_check => input_check }
 #       #format.html { redirect_to @m_info_cost, notice: 'M info cost was successfully updated.' }
 #       format.json { head :ok }
 #     else
 #       format.html { render action: "edit" }
 #       format.json { render json: @m_info_cost.errors, status: :unprocessable_entity }
 #     end
 #   end
 # end

  #ポップアップ用
  def popup_update
    
    inp_data = params[:m_info_cost]
    
    @m_info_cost = MInfoCost.find(:first, :conditions=>["user_id=?", inp_data[:user_id]])
    if @m_info_cost.blank?
      @m_info_cost = MInfoCost.new(inp_data)
      @m_info_cost.save
    else
      @m_info_cost.update_attributes(inp_data)
    end


    
    
    respond_to do |format|
      format.js { render :layout => false }
    end      
  end
  
  # DELETE /m_info_costs/1
  # DELETE /m_info_costs/1.json
 # def destroy
 #   @m_info_cost = MInfoCost.find(params[:id])
 #   #@m_info_cost.destroy
 #   if @m_info_cost.deleted_flg == 1
 #     @m_info_cost.update_attributes(:deleted_flg => 0)
 #   else
 #     @m_info_cost.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
 #   end

 #   respond_to do |format|
 #     input_check = params[:input_check].to_i
 #     format.html { redirect_to :controller => "m_info_costs", :action => "index", :input_check => input_check }
 #     #format.html { redirect_to m_info_costs_url }
 #     format.json { head :ok }
 #   end
 # end
  
 # def search
    
 #   select_sql = "select a.*, b.user_name "
 #   select_sql << " from m_info_costs a " 
 #   select_sql << " left join (select * from users) b on a.user_id = b.id "
    
 #   condition_sql = ""
    
 #   if params[:check][:deleted_flg] == "true"
 #     @check_del_flg = 1
 #     #@m_info_costs = MInfoCost.find(:all, :order => 'users_id')
 #     @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql} order by b.account")
 #   else
 #     @check_del_flg = 0
 #     #@m_info_costs = MInfoCost.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'users_id')
 #     condition_sql = " where a.deleted_flg = 0 "
 #     @m_info_costs = MInfoCost.find_by_sql("#{select_sql} #{condition_sql} order by b.account")
 #   end
 # end
  
end
