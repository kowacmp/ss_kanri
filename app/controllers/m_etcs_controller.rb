class MEtcsController < ApplicationController
  # GET /m_etcs
  # GET /m_etcs.json
  def index
    #@m_etcs = MEtc.all
    
    select_sql = "select a.*, b.code_name as etc_tani_name,c.code_name as etc_group_name,"
    select_sql << "           d.code_name as kansa_flg_name, e.code_name as tax_flg_name " 
    select_sql << " from m_etcs a " 
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.etc_tani = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='m_etc_group') c on a.etc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='kansa_flg') d on a.kansa_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') e on a.tax_flg = cast(e.code as integer) "
    
    condition_sql = ""
    
    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where deleted_flg = 0 "
        #@m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
        @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql} order by a.etc_cd")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where deleted_flg = 0 "
          #@m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
          @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql} order by a.etc_cd")
        else
          #@m_etcs = MEtc.find(:all, :order => 'etc_cd')
          @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql} order by a.etc_cd")
        end
    end
    
    #@m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_etcs }
    end
  end

  # GET /m_etcs/1
  # GET /m_etcs/1.json
  def show
    
    select_sql = "select a.*, b.code_name as etc_tani_name,c.code_name as etc_group_name,"
    select_sql << "           d.code_name as kansa_flg_name, e.code_name as tax_flg_name " 
    select_sql << " from m_etcs a " 
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.etc_tani = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='m_etc_group') c on a.etc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='kansa_flg') d on a.kansa_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') e on a.tax_flg = cast(e.code as integer) "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_etc = @m_etcs[0]
     
    @check_del_flg = params[:input_check].to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_etc }
    end
  end

  # GET /m_etcs/new
  # GET /m_etcs/new.json
  def new
    @m_etc = MEtc.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_etc }
    end
  end

  # GET /m_etcs/1/edit
  def edit
    @m_etc = MEtc.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_etcs
  # POST /m_etcs.json
  def create
    @m_etc = MEtc.new(params[:m_etc])

    respond_to do |format|
      if @m_etc.save
        #format.html { redirect_to @m_etc, notice: 'M etc was successfully created.' }
        format.html { redirect_to @m_etc}
        format.json { render json: @m_etc, status: :created, location: @m_etc }
      else
        format.html { render action: "new" }
        format.json { render json: @m_etc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_etcs/1
  # PUT /m_etcs/1.json
  def update
    @m_etc = MEtc.find(params[:id])

    respond_to do |format|
      if @m_etc.update_attributes(params[:m_etc])
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_etcs", :action => "show",:id=>@m_etc.id,:input_check => input_check }
        #format.html { redirect_to @m_etc, notice: 'M etc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_etc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_etcs/1
  # DELETE /m_etcs/1.json
  def destroy
    @m_etc = MEtc.find(params[:id])
    #@m_etc.destroy
    if @m_etc.deleted_flg == 1
      @m_etc.update_attributes(:deleted_flg => 0)
    else
      @m_etc.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_etcs", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_etcs_url }
      format.json { head :ok }
    end
  end
  
  def search
    
    select_sql = "select a.*, b.code_name as etc_tani_name,c.code_name as etc_group_name,"
    select_sql << "           d.code_name as kansa_flg_name, e.code_name as tax_flg_name " 
    select_sql << " from m_etcs a " 
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.etc_tani = cast(b.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='m_etc_group') c on a.etc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='kansa_flg') d on a.kansa_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') e on a.tax_flg = cast(e.code as integer) "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      #@m_etcs = MEtc.find(:all, :order => 'etc_cd')
      @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql} order by a.etc_cd")
    else
      @check_del_flg = 0
      condition_sql = " where deleted_flg = 0 "
      #@m_etcs = MEtc.find(:all, :conditions => "deleted_flg = 0", :order => 'etc_cd')
      @m_etcs = MEtc.find_by_sql("#{select_sql} #{condition_sql} order by a.etc_cd")
    end
  end
  
end
