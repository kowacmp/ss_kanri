# encoding: utf-8

class MOiletcsController < ApplicationController
  # GET /m_oiletcs
  # GET /m_oiletcs.json
  def index
    #@m_oiletcs = MOiletc.all
    #@m_oiletcs = MOiletc.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oiletc_cd')

    select_sql = "select a.*, b.code_name as oiletc_tani_name,c.code_name as oiletc_group_name,"
    select_sql << "           d.code_name as tax_flg_name, e.code_name as oiletc_trade_name " 
    select_sql << " from m_oiletcs a "
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.oiletc_tani = cast(b.code as integer) " 
    select_sql << " left join (select * from m_codes where kbn='oiletc_group') c on a.oiletc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') d on a.tax_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='umu_flg') e on a.oiletc_trade = cast(e.code as integer) "
    
    condition_sql = ""
    
    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where deleted_flg = 0 "
        @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql} order by a.oiletc_cd")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where deleted_flg = 0 "
          @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql} order by a.oiletc_cd")
        else
          @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql} order by a.oiletc_cd")
        end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_oiletcs }
    end
  end

  # GET /m_oiletcs/1
  # GET /m_oiletcs/1.json
  def show
    #@m_oiletc = MOiletc.find(params[:id])

    select_sql = "select a.*, b.code_name as oiletc_tani_name,c.code_name as oiletc_group_name,"
    select_sql << "           d.code_name as tax_flg_name, e.code_name as oiletc_trade_name " 
    select_sql << " from m_oiletcs a "
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.oiletc_tani = cast(b.code as integer) " 
    select_sql << " left join (select * from m_codes where kbn='oiletc_group') c on a.oiletc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') d on a.tax_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='umu_flg') e on a.oiletc_trade = cast(e.code as integer) "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_oiletc = @m_oiletcs[0]
    
    @check_del_flg = params[:input_check].to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_oiletc }
    end
  end

  # GET /m_oiletcs/new
  # GET /m_oiletcs/new.json
  def new
    @m_oiletc = MOiletc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_oiletc }
    end
  end

  # GET /m_oiletcs/1/edit
  def edit
    @m_oiletc = MOiletc.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_oiletcs
  # POST /m_oiletcs.json
  def create
    @m_oiletc = MOiletc.new(params[:m_oiletc])

    respond_to do |format|
      if @m_oiletc.save
        #format.html { redirect_to @m_oiletc, notice: 'M oiletc was successfully created.' }
        format.html { redirect_to @m_oiletc }
        format.json { render json: @m_oiletc, status: :created, location: @m_oiletc }
      else
        format.html { render action: "new" }
        format.json { render json: @m_oiletc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_oiletcs/1
  # PUT /m_oiletcs/1.json
  def update
    @m_oiletc = MOiletc.find(params[:id])

    respond_to do |format|
      if @m_oiletc.update_attributes(params[:m_oiletc])
        input_check = params[:input][:check].to_i
        format.html { redirect_to :controller => "m_oiletcs", :action => "show",:id=>@m_oiletc.id,:input_check => input_check }
        #format.html { redirect_to @m_oiletc, notice: 'M oiletc was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_oiletc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_oiletcs/1
  # DELETE /m_oiletcs/1.json
  def destroy
    @m_oiletc = MOiletc.find(params[:id])
    #@m_oiletc.destroy
    if @m_oiletc.deleted_flg == 1
      @m_oiletc.update_attributes(:deleted_flg => 0)
    else
      @m_oiletc.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_oiletcs", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_oiletcs_url }
      format.json { head :ok }
    end
  end
  
  def search
    select_sql = "select a.*, b.code_name as oiletc_tani_name,c.code_name as oiletc_group_name,"
    select_sql << "           d.code_name as tax_flg_name, e.code_name as oiletc_trade_name " 
    select_sql << " from m_oiletcs a "
    select_sql << " left join (select * from m_codes where kbn='tani') b on a.oiletc_tani = cast(b.code as integer) " 
    select_sql << " left join (select * from m_codes where kbn='oiletc_group') c on a.oiletc_group = cast(c.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='tax_flg') d on a.tax_flg = cast(d.code as integer) "
    select_sql << " left join (select * from m_codes where kbn='umu_flg') e on a.oiletc_trade = cast(e.code as integer) "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      #@m_oiletcs = MOiletc.find(:all, :order => 'oiletc_cd')
      @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql} order by a.oiletc_cd")
    else
      @check_del_flg = 0
      condition_sql = " where deleted_flg = 0 "
      #@m_oiletcs = MOiletc.find(:all, :conditions => ["deleted_flg is null or deleted_flg <> ?",1], :order => 'oiletc_cd')
      @m_oiletcs = MOiletc.find_by_sql("#{select_sql} #{condition_sql} order by a.oiletc_cd")
    end
  end
  
end
