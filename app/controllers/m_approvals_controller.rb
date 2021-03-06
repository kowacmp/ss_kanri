class MApprovalsController < ApplicationController
  # GET /m_approvals
  # GET /m_approvals.json
  def index
    #@m_approvals = MApproval.all
    
    select_sql = "select a.*, b.display_name"
    select_sql << " ,c.user_name as approval_name1 "
    select_sql << " ,d.user_name as approval_name2 "
    select_sql << " ,e.user_name as approval_name3 "
    select_sql << " ,f.user_name as approval_name4 "
    select_sql << " ,g.user_name as approval_name5 "
    select_sql << " from m_approvals a " 
    select_sql << " left join (select * from menus) b on a.menu_id = b.id "
    select_sql << " left join (select * from users) c on a.approval_id1 = c.id "
    select_sql << " left join (select * from users) d on a.approval_id2 = d.id "
    select_sql << " left join (select * from users) e on a.approval_id3 = e.id "
    select_sql << " left join (select * from users) f on a.approval_id4 = f.id "
    select_sql << " left join (select * from users) g on a.approval_id5 = g.id "
    
    condition_sql = ""

    @m_approvals = MApproval.find_by_sql("#{select_sql} #{condition_sql} order by a.id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @m_approvals }
    end
  end

  # GET /m_approvals/1
  # GET /m_approvals/1.json
  def show
    #@m_approval = MApproval.find(params[:id])
    
    select_sql = "select a.*, b.display_name"
    select_sql << " ,c.user_name as approval_name1 "
    select_sql << " ,d.user_name as approval_name2 "
    select_sql << " ,e.user_name as approval_name3 "
    select_sql << " ,f.user_name as approval_name4 "
    select_sql << " ,g.user_name as approval_name5 "
    select_sql << " from m_approvals a " 
    select_sql << " left join (select * from menus) b on a.menu_id = b.id "
    select_sql << " left join (select * from users) c on a.approval_id1 = c.id "
    select_sql << " left join (select * from users) d on a.approval_id2 = d.id "
    select_sql << " left join (select * from users) e on a.approval_id3 = e.id "
    select_sql << " left join (select * from users) f on a.approval_id4 = f.id "
    select_sql << " left join (select * from users) g on a.approval_id5 = g.id "
    
    condition_sql = " where a.id = " + params[:id]
    
    @m_approvals = MApproval.find_by_sql("#{select_sql} #{condition_sql}")
    
    @m_approval = @m_approvals[0]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @m_approval }
    end
  end

  # GET /m_approvals/new
  # GET /m_approvals/new.json
  def new
    @m_approval = MApproval.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @m_approval }
    end
  end

  # GET /m_approvals/1/edit
  def edit
    @m_approval = MApproval.find(params[:id])
  end

  # POST /m_approvals
  # POST /m_approvals.json
  def create
    @m_approval = MApproval.new(params[:m_approval])

    respond_to do |format|
      if @m_approval.save
        format.html { redirect_to :controller => "m_approvals", :action => "index" }
        #format.html { redirect_to @m_approval }
        format.json { render json: @m_approval, status: :created, location: @m_approval }
      else
        format.html { render action: "new" }
        format.json { render json: @m_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /m_approvals/1
  # PUT /m_approvals/1.json
  def update
    @m_approval = MApproval.find(params[:id])

    respond_to do |format|
      if @m_approval.update_attributes(params[:m_approval])
        format.html { redirect_to :controller => "m_approvals", :action => "index" }
        #format.html { redirect_to @m_approval }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @m_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /m_approvals/1
  # DELETE /m_approvals/1.json
  def destroy
    @m_approval = MApproval.find(params[:id])
    @m_approval.destroy
    
    respond_to do |format|
      format.html { redirect_to m_approvals_url }
      format.json { head :ok }
    end
  end
   
end
