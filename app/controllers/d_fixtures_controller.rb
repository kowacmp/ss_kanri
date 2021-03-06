class DFixturesController < ApplicationController
  def index
    change_input_ymd
  end

  def change_input_ymd
    @shop = MShop.find(current_user.m_shop_id)

    if params[:input_ymd] == nil
      @input_ymd = Time.now.strftime("%Y/%m/%d")
    else
      @input_ymd = params[:input_ymd]
    end
    
    #@fixtures = DFixture.find(:all,:conditions => ['application_date = ?',@input_ymd.delete("/")],:order => 'id')
    @fixtures = DFixture.find(:all,:conditions => ['application_date = ? and m_shop_id=?', 
                                                    @input_ymd.delete("/"), 
                                                    current_user.m_shop_id],
                                                  :order => 'id')
    
  end
  
  def update
    @input_ymd = params[:input_ymd]
    input_ymd_s = @input_ymd.delete("/")
    DFixture.transaction do
      20.times do |i|
        if params["fixture_id_#{i+1}"] == nil or params["fixture_id_#{i+1}"] == ""
          fixture = DFixture.new
        else
          fixture = DFixture.find(params["fixture_id_#{i+1}"].to_s)          
        end          
          #承認後、購入日更新
          if fixture.approve_flg == 1
            fixture.buy_day    = params["buy_day_#{i+1}"].delete("/") unless params["buy_day_#{i+1}"] == nil or params["buy_day_#{i+1}"] == ""
            fixture.updated_user_id = current_user.id 
            fixture.save!
          else #承認前、登録更新
            fixture.application_date = input_ymd_s
            fixture.m_shop_id = current_user.m_shop_id
            fixture.buy_shop   = params["buy_shop_#{i+1}"]
            fixture.buy_item   = params["buy_item_#{i+1}"]
            fixture.buy_num    = params["buy_num_#{i+1}"]
            fixture.buy_price  = params["buy_price_#{i+1}"]
            fixture.buy_object = params["buy_object_#{i+1}"]
            fixture.now_num    = params["now_num_#{i+1}"]
            fixture.buy_day    = params["buy_day_#{i+1}"].delete("/") unless params["buy_day_#{i+1}"] == nil or params["buy_day_#{i+1}"] == ""
            fixture.created_user_id = current_user.id if  fixture.created_user_id == 0
            fixture.updated_user_id = current_user.id 
            unless  params["buy_item_#{i+1}"] == nil or params["buy_item_#{i+1}"] == ""
              fixture.save!
            end 
          end

      end #times
    end #transaction
    
    respond_to do |format|
      @shop = MShop.find(current_user.m_shop_id)
      
      #@fixtures = DFixture.find(:all,:conditions => ['application_date = ?',@input_ymd.delete("/")],:order => 'id')
      @fixtures = DFixture.find(:all,:conditions => ['application_date = ? and m_shop_id=?', 
                                                       @input_ymd.delete("/"), 
                                                       current_user.m_shop_id],
                                                     :order => 'id')
      format.html { render action: "index", notice: 'D wash sale was successfully updated.' }
    end
  end

  def show_comment
    @fixture = DFixture.find(params[:id])
    render :layout => 'modal'
  end
  
  # DELETE /d_fixtures/1
  # DELETE /d_fixtures/1.json
  def destroy
    @input_ymd = params[:input_ymd]
    @d_fixture = DFixture.find(params[:id])
    @d_fixture.destroy

    respond_to do |format|
      #format.html { redirect_to d_fixtures_url }
      #format.json { head :ok }
      format.html { redirect_to  :action => "index",:input_ymd => @input_ymd }
      format.json { head :ok }
    end
  end
  
end
