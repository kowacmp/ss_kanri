# -*- coding:utf-8 -*-
class MFixItemsController < ApplicationController
  # GET /m_fix_items
  # GET /m_fix_items.json
  def index
    #@m_fix_items = MFixItem.all
    
    select_sql = "select a.*, b.code_name as fix_item_class_name "
    select_sql << " from m_fix_items a " 
    select_sql << " left join (select * from m_codes where kbn='fix_item_class') b on a.fix_item_class = cast(b.code as integer) "
    
    condition_sql = ""

    if params[:input_check] == nil
        @check_del_flg = 0
        condition_sql = " where a.deleted_flg = 0 "
        @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql} order by a.fix_item_cd")
    else
        @check_del_flg = params[:input_check].to_i
        if @check_del_flg == 0
          condition_sql = " where a.deleted_flg = 0 "
          @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql} order by a.fix_item_cd")
        else
          @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql} order by a.fix_item_cd")
        end
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_fix_items }
    end
  end

  # GET /m_fix_items/1
  # GET /m_fix_items/1.json
  def show
    #@m_fix_item = MFixItem.find(params[:id])
    
    select_sql = "select a.*, b.code_name as fix_item_class_name "
    select_sql << " from m_fix_items a " 
    select_sql << " left join (select * from m_codes where kbn='fix_item_class') b on a.fix_item_class = cast(b.code as integer) "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_fix_item = @m_fix_items[0]

    @check_del_flg = params[:input_check].to_i
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_fix_item }
    end
  end

  # GET /m_fix_items/new
  # GET /m_fix_items/new.json
  def new
    @m_fix_item = MFixItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_fix_item }
    end
  end

  # GET /m_fix_items/1/edit
  def edit
    @m_fix_item = MFixItem.find(params[:id])
    
    @check_del_flg = params[:input_check].to_i
  end

  # POST /m_fix_items
  # POST /m_fix_items.json
  def create
    @m_fix_item = MFixItem.new(params[:m_fix_item])

    kinsyu_count = MFixItem.find(:all,:conditions=>"fix_item_class=0 and deleted_flg=0").count
    ikkatu_count = MFixItem.find(:all,:conditions=>"fix_item_class=1 and deleted_flg=0").count
    
    unless params[:m_fix_item][:fix_item_class] == nil
      if params[:m_fix_item][:fix_item_class].to_i == 0
        if kinsyu_count >= 6
          @m_fix_item.errors[:fix_item_class] = "固定内訳種別の金種別はこれ以上登録できません。"
        end
      elsif params[:m_fix_item][:fix_item_class].to_i == 1
        if ikkatu_count >= 7
          @m_fix_item.errors[:fix_item_class] = "固定内訳種別の一括はこれ以上登録できません。"
        end
      else
      end
    end


    respond_to do |format|
      
      if @m_fix_item.errors.count > 0
        format.html { render action: "new" }
        format.json { render json: @m_fix_item.errors, status: :unprocessable_entity }
      else
        if @m_fix_item.save
          #format.html { redirect_to @m_fix_item, notice: 'M fix item was successfully created.' }
          format.html { redirect_to @m_fix_item }
          format.json { render json: @m_fix_item, status: :created, location: @m_fix_item }
        else
          format.html { render action: "new" }
          format.json { render json: @m_fix_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /m_fix_items/1
  # PUT /m_fix_items/1.json
  def update
    @m_fix_item = MFixItem.find(params[:id])

    kinsyu_count = MFixItem.find(:all,:conditions=>"fix_item_class=0 and deleted_flg=0").count
    ikkatu_count = MFixItem.find(:all,:conditions=>"fix_item_class=1 and deleted_flg=0").count
    
    
    unless params[:m_fix_item][:fix_item_class] == nil
      if @m_fix_item.fix_item_class.to_i != params[:m_fix_item][:fix_item_class].to_i
        if params[:m_fix_item][:fix_item_class].to_i == 0
          if kinsyu_count >= 6
            @m_fix_item.errors[:fix_item_class] = "固定内訳種別の金種別はこれ以上登録できません。"
          end
        elsif params[:m_fix_item][:fix_item_class].to_i == 1
          if ikkatu_count >= 7
            @m_fix_item.errors[:fix_item_class] = "固定内訳種別の一括はこれ以上登録できません。"
          end
        else
        end
      end
    end


    respond_to do |format|
      
      if @m_fix_item.errors.count > 0
          format.html { render action: "edit" }
          format.json { render json: @m_fix_item.errors, status: :unprocessable_entity }
      else
        if @m_fix_item.update_attributes(params[:m_fix_item])
          input_check = params[:input][:check].to_i
          format.html { redirect_to :controller => "m_fix_items", :action => "show",:id=>@m_fix_item.id,:input_check => input_check }
          #format.html { redirect_to @m_fix_item, notice: 'M fix item was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @m_fix_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /m_fix_items/1
  # DELETE /m_fix_items/1.json
  def destroy
    @m_fix_item = MFixItem.find(params[:id])
    #@m_fix_item.destroy

    if @m_fix_item.deleted_flg == 1
      @m_fix_item.update_attributes(:deleted_flg => 0)
    else
      @m_fix_item.update_attributes(:deleted_flg => 1, :deleted_at => Time.current)
    end
    

    respond_to do |format|
      input_check = params[:input_check].to_i
      format.html { redirect_to :controller => "m_fix_items", :action => "index", :input_check => input_check }
      #format.html { redirect_to m_fix_items_url }
      format.json { head :ok }
    end
  end
  
  
  def search
    
    select_sql = "select a.*, b.code_name as fix_item_class_name "
    select_sql << " from m_fix_items a " 
    select_sql << " left join (select * from m_codes where kbn='fix_item_class') b on a.fix_item_class = cast(b.code as integer) "
    
    condition_sql = ""
    
    if params[:check][:deleted_flg] == "true"
      @check_del_flg = 1
      @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql} order by a.fix_item_cd")
    else
      @check_del_flg = 0
      condition_sql = " where a.deleted_flg = 0 "
      @m_fix_items = MFixItem.find_by_sql("#{select_sql} #{condition_sql} order by a.fix_item_cd")
    end
  end
  
end
