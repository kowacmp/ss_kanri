class MItemAccountsController < ApplicationController
  # GET /m_item_accounts
  # GET /m_item_accounts.json
  def index
    #@m_item_accounts = MItemAccount.all
    
    select_sql = "select a.*, b.code_name as item_account_class_name"
    select_sql << " from m_item_accounts a "
    select_sql << " left join (select * from m_codes where kbn='item_account_class') b on a.item_account_class = cast(b.code as integer) " 
    
    condition_sql = ""
    
    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where deleted_flg = 0 "
        @m_item_accounts = MItemAccount.find_by_sql("#{select_sql} #{condition_sql} order by a.item_account_class,a.item_account_code")
        #@m_item_accounts = MItemAccount.find(:all,:conditions=>"deleted_flg = 0",:order=>"item_account_code")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where deleted_flg = 0 "
          @m_item_accounts = MItemAccount.find_by_sql("#{select_sql} #{condition_sql} order by a.item_account_class,a.item_account_code")
          #@m_item_accounts = MItemAccount.find(:all,:conditions=>"deleted_flg = 0",:order=>"item_account_code")
        else
          @m_item_accounts = MItemAccount.find_by_sql("#{select_sql} #{condition_sql} order by a.item_account_class,a.item_account_code")
          #@m_item_accounts = MItemAccount.find(:all,:order=>"item_account_code")
        end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_item_accounts }
    end
  end

  # GET /m_item_accounts/1
  # GET /m_item_accounts/1.json
  def show
    @m_item_account = MItemAccount.find(params[:id])

    @check_del_flg = params[:input_check].to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_item_account }
    end
  end

  # GET /m_item_accounts/new
  # GET /m_item_accounts/new.json
  def new
    @m_item_account = MItemAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_item_account }
    end
  end

  # GET /m_item_accounts/1/edit
  def edit
    @m_item_account = MItemAccount.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_item_accounts
  # POST /m_item_accounts.json
  def create
    @m_item_account = MItemAccount.new(params[:m_item_account])

    respond_to do |format|
      if @m_item_account.save
        #format.html { redirect_to @m_item_account, notice: 'M item account was successfully created.' }
        format.html { redirect_to :controller => "m_item_accounts", :action => "index" }
        #format.html { redirect_to @m_item_account }
        format.json { render json: @m_item_account, status: :created, location: @m_item_account }
      else
        format.html { render action: "new" }
        format.json { render json: @m_item_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_item_accounts/1
  # PUT /m_item_accounts/1.json
  def update
    @m_item_account = MItemAccount.find(params[:id])

    respond_to do |format|
      if @m_item_account.update_attributes(params[:m_item_account])
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_item_accounts", :action => "index",:input_check => input_check }
        #format.html { redirect_to :controller => "m_item_accounts", :action => "show",:id=>@m_item_account.id,:input_check => input_check }
        #format.html { redirect_to @m_item_account, notice: 'M item account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_item_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_item_accounts/1
  # DELETE /m_item_accounts/1.json
  def destroy
    @m_item_account = MItemAccount.find(params[:id])
    #@m_item_account.destroy
    
    if @m_item_account.deleted_flg == 1
      @m_item_account.update_attributes(:deleted_flg => 0)
    else
      @m_item_account.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_item_accounts", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_item_accounts_url }
      format.json { head :ok }
    end
  end
  
  
  def search
    
    select_sql = "select a.*, b.code_name as item_account_class_name"
    select_sql << " from m_item_accounts a "
    select_sql << " left join (select * from m_codes where kbn='item_account_class') b on a.item_account_class = cast(b.code as integer) " 
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_item_accounts = MItemAccount.find_by_sql("#{select_sql} #{condition_sql} order by a.item_account_class,a.item_account_code")
      #@m_item_accounts = MItemAccount.find(:all,:order=>"item_account_code")
    else
      @check_del_flg = 0
      condition_sql = " where deleted_flg = 0 "
      @m_item_accounts = MItemAccount.find_by_sql("#{select_sql} #{condition_sql} order by a.item_account_class,a.item_account_code")
      #@m_item_accounts = MItemAccount.find(:all,:conditions=>"deleted_flg = 0",:order=>"item_account_code")
    end
  end
  
end
