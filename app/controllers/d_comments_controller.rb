class DCommentsController < ApplicationController
  # GET /d_comments
  # GET /d_comments.json
  def index
    sql =  "select c.*, u.account receive_user_account, u.user_name receive_user_name, m.display_name"
    sql << "  from d_comments c"
    sql << "  left join users u on (c.receive_id = u.id)"
    sql << "  left join menus m on (c.menu_id = m.id)"
    sql << " where created_user_id = #{current_user.id} order by c.send_day desc"
        
    @d_comments = DComment.find_by_sql(sql)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @d_comments }
    end
  end

  # GET /d_comments/1
  # GET /d_comments/1.json
  def show
    @d_comment = DComment.find(params[:id])
    @display_name = Menu.find(@d_comment.menu_id).display_name
    @receive_user = User.find(@d_comment.receive_id)
     
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @d_comment }
    end
  end

  # GET /d_comments/new
  # GET /d_comments/new.json
  def new
    @d_comment = DComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @d_comment }
    end
  end

  # GET /d_comments/1/edit
  def edit
    @d_comment = DComment.find(params[:id])
    @d_comment.send_day = @d_comment.send_day.strftime("%Y/%m/%d")
  end

  # POST /d_comments
  # POST /d_comments.json
  def create
    @d_comment = DComment.new(params[:d_comment])
    @d_comment.created_user_id = current_user.id
    
    respond_to do |format|
      if @d_comment.save
        format.html { redirect_to @d_comment, notice: 'D comment was successfully created.' }
        format.json { render json: @d_comment, status: :created, location: @d_comment }
      else
        format.html { render action: "new" }
        format.json { render json: @d_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /d_comments/1
  # PUT /d_comments/1.json
  def update
    @d_comment = DComment.find(params[:id])

    respond_to do |format|
      if @d_comment.update_attributes(params[:d_comment])
        format.html { redirect_to @d_comment, notice: 'D comment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @d_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_comments/1
  # DELETE /d_comments/1.json
  def destroy
    @d_comment = DComment.find(params[:id])
    @d_comment.destroy

    respond_to do |format|
      format.html { redirect_to d_comments_url }
      format.json { head :ok }
    end
  end
  
  def change_m_shop
    sql = "select * from users where deleted_flg = 0 and user_class = 3"
    unless params[:m_shop_id].blank?
      sql << " and m_shop_id = #{params[:m_shop_id]}"
    end
    sql << " order by account"
    
    @users = User.find_by_sql(sql)
    
    respond_to do |format|
      format.js
    end    
  end
end
