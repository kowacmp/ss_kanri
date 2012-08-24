class MItemAccountsController < ApplicationController
  # GET /m_item_accounts
  # GET /m_item_accounts.json
  def index
    @m_item_accounts = MItemAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_item_accounts }
    end
  end

  # GET /m_item_accounts/1
  # GET /m_item_accounts/1.json
  def show
    @m_item_account = MItemAccount.find(params[:id])

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
  end

  # POST /m_item_accounts
  # POST /m_item_accounts.json
  def create
    @m_item_account = MItemAccount.new(params[:m_item_account])

    respond_to do |format|
      if @m_item_account.save
        format.html { redirect_to @m_item_account, notice: 'M item account was successfully created.' }
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
        format.html { redirect_to @m_item_account, notice: 'M item account was successfully updated.' }
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
    @m_item_account.destroy

    respond_to do |format|
      format.html { redirect_to m_item_accounts_url }
      format.json { head :ok }
    end
  end
end
