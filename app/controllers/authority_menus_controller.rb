class AuthorityMenusController < ApplicationController
  # GET /authority_menus
  # GET /authority_menus.json
  def index
    @authority_menus = AuthorityMenu.all

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
    p "authority_select   authority_select   authority_select"
    p "authority_select=#{params[:select][:authority]}"
    #@authority_menus = AuthorityMenu.all
    sql = "select m.id, m.display_order, m.display_name, a.id authority_menu_id"
    sql << " from menus m left join authority_menus a"
    sql << "   on (m.id = a.menu_id and a.m_authority_id = #{params[:select][:authority]})"
    sql << " order by m.parent_menu_id, m.display_order"
    @authority_menus = Menu.find_by_sql(sql)
  end

  def authority_menu_create
    p "authority_menu_create   authority_menu_create   authority_menu_create"
    p params["menu"]["0"]["chk"]

    params["test"].each do |i|

    end
  end
end
