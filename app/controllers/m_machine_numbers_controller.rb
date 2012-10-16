class MMachineNumbersController < ApplicationController
  # GET /m_machine_numbers
  # GET /m_machine_numbers.json
  def index
    #@m_machine_numbers = MMachineNumber.all
    
    select_sql = "select a.*, b.shop_cd,b.shop_name "
    select_sql << " ,(case a.pos1machineno1 when '' then 0 else 1 end + case a.pos1machineno2 when '' then 0 else 1 end + "
    select_sql << "   case a.pos1machineno3 when '' then 0 else 1 end + case a.pos1machineno4 when '' then 0 else 1 end + "
    select_sql << "   case a.pos1machineno5 when '' then 0 else 1 end + case a.pos1machineno6 when '' then 0 else 1 end + "
    select_sql << "   case a.pos1machineno7 when '' then 0 else 1 end ) as pos1machineno_count "
    select_sql << " ,(case a.pos2machineno1 when '' then 0 else 1 end + case a.pos2machineno2 when '' then 0 else 1 end + "
    select_sql << "   case a.pos2machineno3 when '' then 0 else 1 end + case a.pos2machineno4 when '' then 0 else 1 end + "
    select_sql << "   case a.pos2machineno5 when '' then 0 else 1 end + case a.pos2machineno6 when '' then 0 else 1 end + "
    select_sql << "   case a.pos2machineno7 when '' then 0 else 1 end ) as pos2machineno_count "
    select_sql << " ,(case a.pos3machineno1 when '' then 0 else 1 end + case a.pos3machineno2 when '' then 0 else 1 end + "
    select_sql << "   case a.pos3machineno3 when '' then 0 else 1 end + case a.pos3machineno4 when '' then 0 else 1 end + "
    select_sql << "   case a.pos3machineno5 when '' then 0 else 1 end + case a.pos3machineno6 when '' then 0 else 1 end + "
    select_sql << "   case a.pos3machineno7 when '' then 0 else 1 end ) as pos3machineno_count "
    select_sql << " from m_machine_numbers a " 
    select_sql << " left join (select * from m_shops) b on a.m_shop_id = b.id "
    
    condition_sql = ""
    
    @m_machine_numbers = MMachineNumber.find_by_sql("#{select_sql} #{condition_sql} order by b.shop_cd")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_machine_numbers }
    end
  end

  # GET /m_machine_numbers/1
  # GET /m_machine_numbers/1.json
  def show
    @m_machine_number = MMachineNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_machine_number }
    end
  end

  # GET /m_machine_numbers/new
  # GET /m_machine_numbers/new.json
  def new
    @m_machine_number = MMachineNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_machine_number }
    end
  end

  # GET /m_machine_numbers/1/edit
  def edit
    @m_machine_number = MMachineNumber.find(params[:id])
  end

  # POST /m_machine_numbers
  # POST /m_machine_numbers.json
  def create
    @m_machine_number = MMachineNumber.new(params[:m_machine_number])

    respond_to do |format|
      if @m_machine_number.save
        format.html { redirect_to :controller => "m_machine_numbers", :action => "index" }
        #format.html { redirect_to @m_machine_number, notice: 'M machine number was successfully created.' }
        format.json { render json: @m_machine_number, status: :created, location: @m_machine_number }
      else
        format.html { render action: "new" }
        format.json { render json: @m_machine_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_machine_numbers/1
  # PUT /m_machine_numbers/1.json
  def update
    @m_machine_number = MMachineNumber.find(params[:id])

    respond_to do |format|
      if @m_machine_number.update_attributes(params[:m_machine_number])
        format.html { redirect_to :controller => "m_machine_numbers", :action => "index" }
        #format.html { redirect_to @m_machine_number, notice: 'M machine number was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_machine_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_machine_numbers/1
  # DELETE /m_machine_numbers/1.json
  def destroy
    @m_machine_number = MMachineNumber.find(params[:id])
    @m_machine_number.destroy

    respond_to do |format|
      format.html { redirect_to m_machine_numbers_url }
      format.json { head :ok }
    end
  end
end
