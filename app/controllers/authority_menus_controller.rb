class AuthorityMenusController < ApplicationController
  include AuthorityMenusHelper
  # GET /authority_menus
  # GET /authority_menus.json
  def index
    #@authority_menus = AuthorityMenu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authority_menus }
    end
  end

  # GET /authority_menus/1
  # GET /authority_menus/1.json
  def show
    @authority_menu = AuthorityMenu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @authority_menu }
    end
  end

  # GET /authority_menus/new
  # GET /authority_menus/new.json
  def new
    @authority_menu = AuthorityMenu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authority_menu }
    end
  end

  # GET /authority_menus/1/edit
  def edit
    @authority_menu = AuthorityMenu.find(params[:id])
  end

  # POST /authority_menus
  # POST /authority_menus.json
  def create
    @authority_menu = AuthorityMenu.new(params[:authority_menu])

    respond_to do |format|
      if @authority_menu.save
        format.html { redirect_to @authority_menu, notice: 'Authority menu was successfully created.' }
        format.json { render json: @authority_menu, status: :created, location: @authority_menu }
      else
        format.html { render action: "new" }
        format.json { render json: @authority_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authority_menus/1
  # PUT /authority_menus/1.json
  def update
    @authority_menu = AuthorityMenu.find(params[:id])

    respond_to do |format|
      if @authority_menu.update_attributes(params[:authority_menu])
        format.html { redirect_to @authority_menu, notice: 'Authority menu was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @authority_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authority_menus/1
  # DELETE /authority_menus/1.json
  def destroy
    @authority_menu = AuthorityMenu.find(params[:id])
    @authority_menu.destroy

    respond_to do |format|
      format.html { redirect_to authority_menus_url }
      format.json { head :ok }
    end
  end
  
  def authority_select
    if params[:select][:m_authority_id].blank?
      @authority_menus = Hash.new
    else
      @m_authority_id = params[:select][:m_authority_id]
      
      sql = authority_menu_sql(@m_authority_id)
      @authority_menus = Menu.find_by_sql(sql)
    end
  end

  def authority_menu_create
    return if params[:select].blank?

    m_authority_id = params[:select][:m_authority_id].to_i
    AuthorityMenu.destroy_all(["m_authority_id = ?", m_authority_id])
    menus = Menu.all

    menus.each do |menu|
      if params["#{menu.id}"]["chk"] == "on"
        authority_menu = AuthorityMenu.new
        authority_menu.m_authority_id = m_authority_id
        authority_menu.menu_id = menu.id
        authority_menu.save
      end
    end
    
    #ログイン中の権限を変更した場合はメニューの再取得
    get_menus(current_user.m_authority_id) if current_user.m_authority_id == m_authority_id

  end
end
