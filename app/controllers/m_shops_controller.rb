# -*- coding:utf-8 -*-
class MShopsController < ApplicationController

  # GET /m_shops
  # GET /m_shops.json
  def index
    #@m_shops = MShop.all
    @m_shops = MShop.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'shop_cd')
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'oil_cd')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_shops }
    end
  end

  # GET /m_shops/1
  # GET /m_shops/1.json
  def show
    p "m_shop show---------------------"
    @m_shop = MShop.find(params[:id])
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'oil_cd')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_shop }
    end
  end

  # GET /m_shops/new
  # GET /m_shops/new.json
  def new
    @m_shop = MShop.new
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'oil_cd')

    #@m_tanks = MTank.find(:all,
    #                      :conditions => ["deleted_flg is null or deleted_flg <> ?",1],
    #                      :order => 'm_shop_id,m_oil_id')
    @m_tanks = nil


    
    @m_washsale_plans = nil


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_shop }
    end
  end

  # GET /m_shops/1/edit
  def edit
    @m_shop = MShop.find(params[:id])
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'oil_cd')
    
    sql_where = "m_shop_id = ?"
    sql_where = sql_where + " and deleted_flg = ?"
    
    @m_tanks = MTank.find(:all,:conditions => [sql_where,params[:id],0],:order => 'tank_no')
    
    sql = "select a.*,b.wash_ryaku 
          from m_washsale_plans a
          left join m_washes b 
          on a.m_wash_id = b.id
          where a.deleted_flg = 0
          and a.m_shop_id = " + params[:id] +
          " order by b.wash_cd"
    @m_washsale_plans = MWashsalePlan.find_by_sql(sql)
    
    @m_fix_moneys = MFixMoney.find(:all,
                                   :conditions=>["m_shop_id = ? and deleted_flg = ?",params[:id],0])
    
  end

  # POST /m_shops
  # POST /m_shops.json
  def create
    #店舗情報　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_shop = MShop.new(params[:m_shop])
    
    @m_shop.save
    #店舗情報　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    #洗車売上報告　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    if params[:m_washsale_plan]
      params[:m_washsale_plan].each do |key,value| 
        @m_washsale_plan = MWashsalePlan.new(value)
        @m_washsale_plan.m_shop_id = @m_shop.id
        @m_washsale_plan.save
      end
    end
    #洗車売上報告　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    #釣銭固定額　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ##洗車売上報告有無が「有」の場合、保存
    #if params[:m_shop][:wash_sale_flg] = 1
        if params[:m_fix_money]
          params[:m_fix_money].each do |key,value| 
            @m_fix_money = MFixMoney.new(value)
            @m_fix_money.m_shop_id = @m_shop.id
            @m_fix_money.save
          end
        end
    #end
    #釣銭固定額　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


    #タンク情報　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    if params[:m_tank]
      params[:m_tank].each do |key,value| 
        @m_tank = MTank.new(value)
        @m_tank.m_shop_id = @m_shop.id
        @m_tank.save
      end
    end
    #タンク情報　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



    respond_to do |format|
      #if @m_shop.save
        format.html { redirect_to @m_shop, notice: 'M shop was successfully created.' }
        format.json { render json: @m_shop, status: :created, location: @m_shop }
      #else
      #  format.html { render action: "new" }
      #  format.json { render json: @m_shop.errors, status: :unprocessable_entity }
      #end
    end
  end

  # PUT /m_shops/1
  # PUT /m_shops/1.json
  def update
    
    #店舗情報　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_shop = MShop.find(params[:id])
    @m_shop.update_attributes(params[:m_shop])
    #店舗情報　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    #洗車売上報告　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    #初めにdelete insert の替わりに削除フラグを立てる
    @m_washsale_plans = MWashsalePlan.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_washsale_plans.each do |m_washsale_plan| 
      m_washsale_plan.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    #idを見てあれば更新、無ければ新規作成
    if params[:m_washsale_plan]
      params[:m_washsale_plan].each do |key,value| 
        @m_washsale_plan = MWashsalePlan.find(:first,:conditions=>["id = ?",value['id']])
  
        if @m_washsale_plan == nil then
          @m_washsale_plan = MWashsalePlan.new(value)
          @m_washsale_plan.m_shop_id = params[:id]
          @m_washsale_plan.save      
        else
          @m_washsale_plan.deleted_flg = 0
          @m_washsale_plan.deleted_at = nil
          @m_washsale_plan.update_attributes(value)
        end
      end
    end
    #洗車売上報告　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    #釣銭固定額　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    ##洗車売上報告有無が「有」の場合、保存
    #if params[:m_shop][:wash_sale_flg] = 1
        #初めにdelete insert の替わりに削除フラグを立てる
        @m_fix_moneys = MFixMoney.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
        
        @m_fix_moneys.each do |m_fix_money| 
          m_fix_money.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
        end
        p params[:m_fix_money]
        #idを見てあれば更新、無ければ新規作成
        if params[:m_fix_money]
          params[:m_fix_money].each do |key,value| 
            @m_fix_money = MFixMoney.find(:first,:conditions=>["id = ?",value['id']])
      
            if @m_fix_money == nil then
              @m_fix_money = MFixMoney.new(value)
              @m_fix_money.m_shop_id = params[:id]
              @m_fix_money.save      
            else
              @m_fix_money.deleted_flg = 0
              @m_fix_money.deleted_at = nil
              @m_fix_money.update_attributes(value)
            end
          end
        end
    
    #end
    #釣銭固定額　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    #タンク情報　保存 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    #初めにdelete insert の替わりに削除フラグを立てる
    @m_tanks = MTank.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_tanks.each do |m_tank| 
      m_tank.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end

    #idを見てあれば更新、無ければ新規作成
    if params[:m_tank]
      params[:m_tank].each do |key,value| 
        
        @m_tank = MTank.find(:first,:conditions=>["id = ?",value['id']])
        
        if @m_tank == nil then
          @m_tank = MTank.new(value)
          @m_tank.m_shop_id = params[:id]
          @m_tank.save      
        else
          @m_tank.deleted_flg = 0
          @m_tank.deleted_at = nil
          @m_tank.update_attributes(value)
        end
        
      end
    end
    #タンク情報　保存 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    
    

    respond_to do |format|
    #  if @m_shop.update_attributes(params[:m_shop])
        format.html { redirect_to @m_shop, notice: 'M shop was successfully updated.' }
        format.json { head :ok }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @m_shop.errors, status: :unprocessable_entity }
    #  end
    end
  end

  # DELETE /m_shops/1
  # DELETE /m_shops/1.json
  def destroy
    
    #店舗情報　削除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_shop = MShop.find(params[:id])
    #@m_shop.destroy
    @m_shop.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    
    
    #洗車売上報告　削除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_washsale_plans = MWashsalePlan.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_washsale_plans.each do |m_washsale_plan| 
      m_washsale_plan.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end
    
    
    #釣銭固定額　削除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_fix_moneys = MFixMoney.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_fix_moneys.each do |m_fix_money| 
      m_fix_money.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end


    #タンク情報　削除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_tanks = MTank.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_tanks.each do |m_tank| 
      m_tank.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end
    
    
    #計量機情報　削除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    @m_meters = MMeter.find(:all,:conditions=>["m_shop_id = ?",params[:id]])
    
    @m_meters.each do |m_meter| 
      m_meter.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end
    


    respond_to do |format|
      format.html { redirect_to m_shops_url }
      format.json { head :ok }
    end
  end
  
  
  
  def search 
    p "search-----------------------------------"
    
    sql_where = "deleted_flg = 0"
    
    if params[:select][:shop_kbn] != ""
      sql_where = sql_where + " and shop_kbn = " + params[:select][:shop_kbn]
    end
    
    if params[:select][:shop_from] != ""
      sql_where = sql_where + " and shop_cd >= " + params[:select][:shop_from]
    end
    
    if params[:select][:shop_to] != ""
      sql_where = sql_where + " and shop_cd <= " + params[:select][:shop_to]
    end
    
    @m_shops = MShop.find(:all, :conditions => [sql_where], :order => 'shop_cd')
    
    @m_oils = MOil.find(:all, :conditions => ["deleted_flg = ?",0], :order => 'oil_cd')

  end
  
end
