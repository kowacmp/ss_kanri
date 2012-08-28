class DFixtureApprovalsController < ApplicationController
  def index
    menu = Menu.find(:all,:conditions => ['uri = ?','d_fixture_approvals']).first
    m_approval = MApproval.find(:all,:conditions => ['menu_id = ?',menu.id]).first
    if m_approval.approval_id1 == current_user.id
      @appraval_id = m_approval.approval_id1
      @approval_name = m_approval.approval_name1
    elsif m_approval.approval_id2 == current_user.id
      @appraval_id = m_approval.approval_id2
      @approval_name = m_approval.approval_name2
    elsif m_approval.approval_id3 == current_user.id
      @appraval_id = m_approval.approval_id3
      @approval_name = m_approval.approval_name3
    elsif m_approval.approval_id4 == current_user.id
      @appraval_id = m_approval.approval_id4
      @approval_name = m_approval.approval_name4
    elsif m_approval.approval_id5 == current_user.id
      @appraval_id = m_approval.approval_id5
      @approval_name = m_approval.approval_name5
    end
    
    search
    #unless @appraval_id == nil
    #  @fixtures = DFixture.find(:all,:order => 'application_date,id')
    #end
  end

  def edit
    @shop_kbn = params[:shop_kbn]
    @from_ymd = params[:from_ymd]
    @to_ymd = params[:to_ymd]
    @fixtures = DFixture.find(:all,:conditions => ['application_date = ? and created_user_id = ? and m_shop_id = ?',
      params[:date],params[:user_id],params[:shop_id]],:order => 'id')
  end

  def entry_comment
    @fixture = DFixture.find(params[:id])
    render :layout => 'modal'
  end
  
  def search
    if params[:from_ymd] == nil or params[:from_ymd] == ''
      @from_ymd = '00000000'
    else
      @from_ymd = params[:from_ymd].delete("/")     
    end

    if params[:to_ymd] == nil or params[:to_ymd] == ''
      @to_ymd = '99999999'
    else
      @to_ymd = params[:to_ymd] .delete("/")    
    end
    @shop_kbn = params[:shop_kbn]
    
    if @from_ymd == '00000000' and @to_ymd == '99999999'
    else
      @fixtures = DFixture.find_by_sql(['select application_date,m_shop_id,created_user_id from d_fixtures
                    where application_date between ? and ?
                    group by application_date,m_shop_id,created_user_id
                    order by application_date,m_shop_id,created_user_id',@from_ymd,@to_ymd])
    end
  end
  
  def update_comment
    @fixture = DFixture.find(params[:id])
    @fixture.comment = params[:comment]
    @fixture.updated_user_id = current_user.id
    @fixture.save!
  end
  
  def change_radio
    @fixture = DFixture.find(params[:id])
    @fixture.approve_flg = params[:value]
    @fixture.updated_user_id = current_user.id
    @fixture.save!
  end
end
