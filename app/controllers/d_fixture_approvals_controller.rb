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
    
    unless @appraval_id == nil
      @fixtures = DFixture.find(:all,:order => 'application_date,id')
    end
  end

  def edit
  end

  def entry_comment
    @fixture = DFixture.find(params[:id])
    render :layout => 'modal'
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
