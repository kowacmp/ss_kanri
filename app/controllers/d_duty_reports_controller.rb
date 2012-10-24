# -*- coding:utf-8 -*-
class DDutyReportsController < ApplicationController
  
  helper :d_duties
  
  def index
  end

  def show
    params[:from_view] = "syoukai_menu"
    @from_view = params[:from_view]
    
    @head = DDuty.new

    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
      
    if params[:input_day].blank?
      @head[:input_day] = Time.now.localtime.strftime("%Y%m")
    else
      @head[:input_day] = params[:input_day].to_s.gsub("/", "")
      @head[:input_day] = @head[:input_day][0,6]
    end

    if params[:head_input_m_shop_id] == nil
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:head_input_m_shop_id]
    end
    
    if params[:head_output_kbn] == nil
      @head_output_kbn = 1 #金額を表示
    else
      @head_output_kbn = params[:head_output_kbn].to_i
    end
    
    #selectboxの選択年度を設定

    @start_year = Time.now.localtime.strftime("%Y").to_i - 1
   
    @m_shop = MShop.find(@m_shop_id)
   
    #コメントデータを取得する
    if @from_view == "syoukai_menu"
      @d_comment1 = DComment.find(:first,:conditions=>["m_shop_id=? and nengetu=? and renban=1", @m_shop_id, @head[:input_day]])
      if @d_comment1.blank?
        @d_comment1 = DComment.new
        @d_comment1.title = "人件費表コメント(#{@head[:input_day][0,4]}/#{@head[:input_day][4,2]}/10)"
        @d_comment1.renban = 1
      end
      @d_comment2 = DComment.find(:first,:conditions=>["m_shop_id=? and nengetu=? and renban=2", @m_shop_id, @head[:input_day]])
      if @d_comment2.blank?
        @d_comment2 = DComment.new
        @d_comment2.title = "人件費表コメント(#{@head[:input_day][0,4]}/#{@head[:input_day][4,2]}/20)"
        @d_comment2.renban = 2
      end 
      @d_comment3 = DComment.find(:first,:conditions=>["m_shop_id=? and nengetu=? and renban=3", @m_shop_id, @head[:input_day]])
      @d_comment3 = DComment.new if @d_comment3.blank?
      @d_comment3.title = "人件費表コメント(#{@head[:input_day][0,4]}/#{@head[:input_day][4,2]}/末)"
      @d_comment3.renban = 2
    end
       
    respond_to do |format|
      if params[:remote]
        format.html { render :partial => 'form'  }
      else
        format.html 
      end
    end    
  end

  #コメントデータを更新
  def comment_add
    @err_msg = ""
    
    #コメントを登録する対象者を抽出する（人件費入力ができる人）
    select_sql = "select a.id as id "
    select_sql << "from users a inner join authority_menus b on a.m_authority_id = b.m_authority_id"
    select_sql << " where a.m_shop_id = #{params[:m_shop_id].to_i}" 
    select_sql << " and b.menu_id = 9"
    select_sql << " and a.deleted_flg = 0"
    users = User.find_by_sql(select_sql)
    p select_sql
    unless users[0].blank?
      for user in users
        #一旦削除
        delete_sql = "delete from d_comments where receive_id=#{user.id} and  m_shop_id=#{params[:m_shop_id].to_i} and nengetu='#{params[:input_day]}' and renban=#{params[:renban].to_i}"
        ActiveRecord::Base::connection.execute(delete_sql)
        
        d_comment = DComment.find(:first,:conditions=>["receive_id=? and  m_shop_id=? and nengetu=? and renban=?", user.id, params[:m_shop_id].to_i, params[:input_day], params[:renban].to_i])
        if d_comment.blank?
            d_comment = DComment.new
            d_comment.send_day = Time.now
            d_comment.receive_id = user.id
            d_comment.m_shop_id = params[:m_shop_id]
            d_comment.nengetu = params[:input_day]
            d_comment.renban = params[:renban]
            d_comment.created_user_id = current_user.id
        end
        if params[:d_comment][:title].blank?
          d_comment.title =  ""
        else
          d_comment.title = params[:d_comment][:title]
        end
        if params[:d_comment][:contents].blank?
          d_comment.contents =  " "
        else
          d_comment.contents = params[:d_comment][:contents]
        end
        
        d_comment.save
      end
    else
      @err_msg = "コメントを送る社員がいません。コメント登録できませんでした。"
    end
  end
  
private
  #分割した日付を１つにする
  def input_day_set(day)
    
    
    if params["#{day}(1i)"].blank?
      return ""
    else
      if params["#{day}(2i)"].blank?
        return params["#{search_day}(1i)"] + "0101"
      else
        if params["#{day}(3i)"].blank?
          return params["#{day}(1i)"] + 
                                 sprintf("%02d",params["#{day}(2i)"].to_i) + "01"
        else
          return params["#{day}(1i)"] + 
                                 sprintf("%02d",params["#{day}(2i)"].to_i) + 
                                 sprintf("%02d",params["#{day}(3i)"].to_i)
        end
      end
    end    
  end

end
