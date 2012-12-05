class MItemsController < ApplicationController
  # GET /m_items
  # GET /m_items.json
  def index
    #@m_items = MItem.all

    select_sql = "select a.*, b.code_name as item_class_name,"
    select_sql << "           c.item_account_code,c.item_account_name, " 
    select_sql << "           d.code_name as item_account_class_name " 
    select_sql << " from m_items a " 
    select_sql << " left join (select * from m_codes where kbn='item_class') b on a.item_class = cast(b.code as integer) "
    select_sql << " left join (select * from m_item_accounts) c on a.m_item_account_id = c.id "
    select_sql << " left join (select * from m_codes where kbn='item_account_class') d on c.item_account_class = cast(d.code as integer) "
    
    condition_sql = ""

    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where a.deleted_flg = 0 "
        @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql} order by a.item_class,a.m_item_account_id,a.item_kana,a.item_name")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where a.deleted_flg = 0 "
          @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql} order by a.item_class,a.m_item_account_id,a.item_kana,a.item_name")
        else
          @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql} order by a.item_class,a.m_item_account_id,a.item_kana,a.item_name")
        end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_items }
    end
  end

  # GET /m_items/1
  # GET /m_items/1.json
  def show
    #@m_item = MItem.find(params[:id])
    
    select_sql = "select a.*, b.code_name as item_class_name,"
    select_sql << "           c.item_account_name " 
    select_sql << " from m_items a " 
    select_sql << " left join (select * from m_codes where kbn='item_class') b on a.item_class = cast(b.code as integer) "
    select_sql << " left join (select * from m_item_accounts) c on a.m_item_account_id = c.id "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_item = @m_items[0]

    @check_del_flg = params[:input_check].to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_item }
    end
  end

  # GET /m_items/new
  # GET /m_items/new.json
  def new
    @m_item = MItem.new
    
    #select_sql = "select a.*, b.code_name as item_account_class_name"
    #select_sql << " from m_item_accounts a " 
    #select_sql << " left join (select * from m_codes where kbn='item_account_class') b on a.item_account_class = cast(b.code as integer) "
    
    #@m_item_accounts = MItemAccount.find_by_sql("#{select_sql} order by a.item_account_class,a.item_account_code")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_item }
    end
  end

  # GET /m_items/1/edit
  def edit
    @m_item = MItem.find(params[:id])
    
    #select_sql = "select a.*, b.code_name as item_account_class_name"
    #select_sql << " from m_item_accounts a " 
    #select_sql << " left join (select * from m_codes where kbn='item_account_class') b on a.item_account_class = cast(b.code as integer) "
    
    #@m_item_accounts = MItemAccount.find_by_sql("#{select_sql} order by a.item_account_class,a.item_account_code")
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_items
  # POST /m_items.json
  def create
    @m_item = MItem.new(params[:m_item])
require 'nkf'
@m_item.item_kana = NKF::nkf('-Z1 -Ww', @m_item.item_kana) #
    respond_to do |format|
      if @m_item.save
        #format.html { redirect_to @m_item, notice: 'M item was successfully created.' }
        format.html { redirect_to :controller => "m_items", :action => "index" }
        #format.html { redirect_to @m_item }
        format.json { render json: @m_item, status: :created, location: @m_item }
      else
        format.html { render action: "new" }
        format.json { render json: @m_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_items/1
  # PUT /m_items/1.json
  def update
    @m_item = MItem.find(params[:id])
require 'nkf'
params[:m_item][:item_kana] = NKF::nkf('-Z1 -Ww', params[:m_item][:item_kana])
    respond_to do |format|
      if @m_item.update_attributes(params[:m_item])
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_items", :action => "index",:input_check => input_check }
        #format.html { redirect_to :controller => "m_items", :action => "show",:id=>@m_item.id,:input_check => input_check }
        #format.html { redirect_to @m_item, notice: 'M item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_items/1
  # DELETE /m_items/1.json
  def destroy
    @m_item = MItem.find(params[:id])
    #@m_item.destroy

    if @m_item.deleted_flg == 1
      @m_item.update_attributes(:deleted_flg => 0)
    else
      @m_item.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end


    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_items", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_items_url }
      format.json { head :ok }
    end
  end
  
  def search
    
    select_sql = "select a.*, b.code_name as item_class_name,"
    select_sql << "           c.item_account_code,c.item_account_name, " 
    select_sql << "           d.code_name as item_account_class_name " 
    select_sql << " from m_items a " 
    select_sql << " left join (select * from m_codes where kbn='item_class') b on a.item_class = cast(b.code as integer) "
    select_sql << " left join (select * from m_item_accounts) c on a.m_item_account_id = c.id "
    select_sql << " left join (select * from m_codes where kbn='item_account_class') d on c.item_account_class = cast(d.code as integer) "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql} order by a.item_class,a.m_item_account_id,a.item_kana, a.item_name")
    else
      @check_del_flg = 0
      condition_sql = " where a.deleted_flg = 0 "
      @m_items = MItem.find_by_sql("#{select_sql} #{condition_sql} order by a.item_class,a.m_item_account_id,a.item_kana, a.item_name")
    end
    
  end
  
end
