class DAuditChangemachinesController < ApplicationController
  # GET /d_audit_changemachines
  # GET /d_audit_changemachines.json
  def index

    @m_shops = MShop.find(current_user.m_shop_id)

  end
  
  def hyouji_index

    # 釣銭機内監査データ読込
    @d_audit_changemachine = DAuditChangemachine.find(:all, :conditions => 
      ["audit_date=? AND audit_class=0 AND m_shop_id=?",
          params[:kansa][:ymd].gsub("/",""),
          current_user.m_shop_id])
   
    # データがない場合は新規
    if @d_audit_changemachine.length == 0 then
      @d_audit_changemachine = DAuditChangemachine.new()
      
      #監査日を設定しておく。
      @d_audit_changemachine.audit_date  = params[:kansa][:ymd].gsub("/","");
      
    end
   
  end

  # GET /d_audit_changemachines/1
  # GET /d_audit_changemachines/1.json
  def show
    @d_audit_changemachine = DAuditChangemachine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_audit_changemachine }
    end
  end

  # GET /d_audit_changemachines/new
  # GET /d_audit_changemachines/new.json
  def new
    @d_audit_changemachine = DAuditChangemachine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_audit_changemachine }
    end
  end

  # GET /d_audit_changemachines/1/edit
  def edit
    @d_audit_changemachine = DAuditChangemachine.find(params[:id])
  end

  # POST /d_audit_changemachines
  # POST /d_audit_changemachines.json
  def create
    @d_audit_changemachine = DAuditChangemachine.new(params[:d_audit_changemachine])

    respond_to do |format|
      if @d_audit_changemachine.save
        format.html { redirect_to @d_audit_changemachine, notice: 'D audit changemachine was successfully created.' }
        format.json { render json: @d_audit_changemachine, status: :created, location: @d_audit_changemachine }
      else
        format.html { render action: "new" }
        format.json { render json: @d_audit_changemachine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_audit_changemachines/1
  # PUT /d_audit_changemachines/1.json
  def update
    
    #@d_audit_changemachine = DAuditChangemachine.find(params[:id])
    #
    #respond_to do |format|
    #  if @d_audit_changemachine.update_attributes(params[:d_audit_changemachine])
    #    format.html { redirect_to @d_audit_changemachine, notice: 'D audit changemachine was successfully updated.' }
    #    format.json { head :ok }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @d_audit_changemachine.errors, status: :unprocessable_entity }
    #  end
    #end

    #更新日時をバッファ
    upd_time = Time.now 

    #書込先読込
    @d_audit_changemachine = DAuditChangemachine.find(:first, :conditions => 
      ["audit_date=? AND audit_class=0 AND m_shop_id=?",
          params[:d_audit_changemachine][:audit_date],
          current_user.m_shop_id])
    
    #新規の場合
    if @d_audit_changemachine.nil? then
      @d_audit_changemachine = DAuditChangemachine.new()
      
      # form_forで定義されていない部分の初期化
      @d_audit_changemachine.audit_class = 0
      @d_audit_changemachine.m_shop_id = current_user.m_shop_id
      @d_audit_changemachine.kakutei_flg = 0
      @d_audit_changemachine.kakunin_flg = 0
      
      @d_audit_changemachine.created_user_id = current_user.id
      @d_audit_changemachine.created_at = upd_time
    end

    #form_forで生成された部分の取得
    d_audit_changemachine = params[:d_audit_changemachine]
    
    #form_forで生成された部分の同期
    @d_audit_changemachine.attributes = d_audit_changemachine

    #立会人
    @d_audit_changemachine.confirm_shop_id = params[:confirm][:shop_id]
    @d_audit_changemachine.confirm_user_id = params[:confirm][:user_id]

    #タイムスタンプ情報
    @d_audit_changemachine.updated_user_id = current_user.id
    @d_audit_changemachine.updated_at = upd_time
    
    #commit
    @d_audit_changemachine.save
    
    #トップに戻る
    redirect_to :action => "index"

  end

  # DELETE /d_audit_changemachines/1
  # DELETE /d_audit_changemachines/1.json
  def destroy
    @d_audit_changemachine = DAuditChangemachine.find(params[:id])
    @d_audit_changemachine.destroy

    respond_to do |format|
      format.html { redirect_to d_audit_changemachines_url }
      format.json { head :ok }
    end
  end
end
