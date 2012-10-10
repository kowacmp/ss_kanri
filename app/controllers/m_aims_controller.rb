class MAimsController < ApplicationController
  # GET /m_aims
  # GET /m_aims.json
  def index
    #@m_aims = MAim.all
    
    select_sql = "select a.*, b.code_name as shop_kbn_name,"
    select_sql << "           c.code_name as input_kbn_name, d.code_name as aim_tani_name " 
    select_sql << " from m_aims a " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') b on a.shop_kbn = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='input_kbn') c on a.input_kbn = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tani') d on a.aim_tani = cast(d.code as integer) "
    
    condition_sql = ""

    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where a.deleted_flg = 0 "
        @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where a.deleted_flg = 0 "
          @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")
        else
          @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")
        end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_aims }
    end
  end

  # GET /m_aims/1
  # GET /m_aims/1.json
  def show
    #@m_aim = MAim.find(params[:id])
    
    select_sql = "select a.*, b.code_name as shop_kbn_name,"
    select_sql << "           c.code_name as input_kbn_name, d.code_name as aim_tani_name " 
    select_sql << " from m_aims a " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') b on a.shop_kbn = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='input_kbn') c on a.input_kbn = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tani') d on a.aim_tani = cast(d.code as integer) "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_aim = @m_aims[0]

    @check_del_flg = params[:input_check].to_i
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_aim }
    end
  end

  # GET /m_aims/new
  # GET /m_aims/new.json
  def new
    @m_aim = MAim.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_aim }
    end
  end

  # GET /m_aims/1/edit
  def edit
    @m_aim = MAim.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_aims
  # POST /m_aims.json
  def create
    @m_aim = MAim.new(params[:m_aim])

    respond_to do |format|
      if @m_aim.save
        #format.html { redirect_to @m_aim, notice: 'M aim was successfully created.' }
        format.html { redirect_to :controller => "m_aims", :action => "index" }
        #format.html { redirect_to @m_aim }
        format.json { render json: @m_aim, status: :created, location: @m_aim }
      else
        format.html { render action: "new" }
        format.json { render json: @m_aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_aims/1
  # PUT /m_aims/1.json
  def update
    @m_aim = MAim.find(params[:id])

    respond_to do |format|
      if @m_aim.update_attributes(params[:m_aim])
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_aims", :action => "index",:input_check => input_check }
        #format.html { redirect_to :controller => "m_aims", :action => "show",:id=>@m_aim.id,:input_check => input_check }
        #format.html { redirect_to @m_aim, notice: 'M aim was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_aim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_aims/1
  # DELETE /m_aims/1.json
  def destroy
    @m_aim = MAim.find(params[:id])
    #@m_aim.destroy
    
    if @m_aim.deleted_flg == 1
      @m_aim.update_attributes(:deleted_flg => 0)
    else
      @m_aim.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_aims", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_aims_url }
      format.json { head :ok }
    end
  end
  
  def search
    
    select_sql = "select a.*, b.code_name as shop_kbn_name,"
    select_sql << "           c.code_name as input_kbn_name, d.code_name as aim_tani_name " 
    select_sql << " from m_aims a " 
    select_sql << " left join (select * from m_codes where kbn='shop_kbn') b on a.shop_kbn = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='input_kbn') c on a.input_kbn = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tani') d on a.aim_tani = cast(d.code as integer) "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")
    else
      @check_del_flg = 0
      condition_sql = " where a.deleted_flg = 0 "
      @m_aims = MAim.find_by_sql("#{select_sql} #{condition_sql} order by a.aim_code")
    end
  end
  
end
