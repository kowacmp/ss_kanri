# -*- coding:utf-8 -*-
class DDutyReportsController < ApplicationController
  
  #2012/10/24 Controller内でhelperを使用したいため変更
  helper :d_duties
  include DDutiesHelper
  include DDutyReportsHelper
  
  def index
  end

  def show
    #ユーザを表示するしないのパラメータ
    @user_disp = params[:user_disp]
    #"syoukai_menu"がセットされていたらコメント入力ができる
    @from_view = params[:from_view]
    if @from_view == "syoukai_menu"
      if @user_disp.blank?
        @user_disp = "0"
      end
    end
    
    #ユーザを表示するしない(デフォルトは表示する)
    if @user_disp.blank?
      @user_disp =  "1"
    end    
    
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
  


  def print
    @head = DDuty.new
    params[:input_day] = input_day_set("input_day") if params[:input_day] == nil
      
    if params[:input_day].blank?
      @head[:input_day] = Time.now.localtime.strftime("%Y%m")
    else
      @head[:input_day] = params[:input_day].to_s.gsub("/", "")
      @head[:input_day] = @head[:input_day][0,6]
    end
    
    if params[:input_m_shop_id] == nil
      @m_shop_id = current_user.m_shop_id
    else
      @m_shop_id = params[:input_m_shop_id]
    end
    
    if params[:head_output_kbn] == nil
      @head_output_kbn = 1 #金額を表示
    else
      @head_output_kbn = params[:head_output_kbn].to_i
    end
    
    #"syoukai_menu"がセットされていたらコメント入力ができる
    @from_view = params[:head_from_view]
       
    @m_shop = MShop.find(@m_shop_id)
    
    jinken = Hash.new
    jinken_total = 0
    uriage = Hash.new
    uriage_total = 0
    
    u_total_label = ""
    u_pace_label = ""
    
    if @from_view == 'syoukai_menu'
      #入力状況から来た場合
      select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and  m_shop_id = #{@m_shop.id} and kakutei_flg = 1 "
    else
      select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and  m_shop_id = #{@m_shop.id} and input_flg = 1 "
    end
    pace_nisu = DDuty.find_by_sql("select day nisu from d_duties where #{select_where} group by day") ?
                  DDuty.find_by_sql("select day nisu from d_duties where #{select_where} group by day").count : 0
    
    loopcnt = (Date.new(@head[:input_day].to_s[0,4].to_i, @head[:input_day].to_s[4,2].to_i, -1)).strftime("%d").to_i
    
    report = ThinReports::Report.new :layout =>  File.join(Rails.root,'app','reports', 'd_duty_list.tlf')
    
    jinken_total_n = 0
    uriage_total_n = 0

    report.layout.config.list(:list) do
    # フッターに合計をセット.
      events.on :footer_insert do |e|
        loopcnt.times do |i|
          e.section.item("j_total_#{i+1}").value(jinken[i+1])
          e.section.item("u_total_#{i+1}").value(uriage[i+1])
          
          jinken_total_n = jinken_total_n + jinken[i+1].to_i
          uriage_total_n = uriage_total_n + uriage[i+1].to_i
          
          if jinken[i+1].to_i == 0
            e.section.item("y_sisu_total_#{i+1}").value(0)
            e.section.item("win_#{i+1}").value(0)
          else
            e.section.item("y_sisu_total_#{i+1}").value((uriage[i+1].to_f/jinken[i+1].to_f*100).to_i)
            e.section.item("win_#{i+1}").value(uriage[i+1].to_i-jinken[i+1].to_i)
          end
          
          if jinken_total_n.to_i == 0
            e.section.item("y_sisu_avg_#{i+1}").value(0)
          else
            e.section.item("y_sisu_avg_#{i+1}").value((uriage_total_n.to_f/jinken_total_n.to_f*100).to_i)
          end
        end # times
        
        e.section.item(:u_total_label).value(u_total_label)
        e.section.item(:u_pace_label).value(u_pace_label)
        
        e.section.item(:j_total).value(jinken_total)
        e.section.item(:u_total).value(uriage_total)
        
        if jinken_total.to_i == 0
          e.section.item(:win_total).value(0)
        else
          e.section.item(:win_total).value(uriage_total.to_i-jinken_total.to_i)
        end 
        
        #ペース
        if pace_nisu == 0
          e.section.item(:j_pace).value("")
          e.section.item(:u_pace).value("")
          e.section.item(:win_pace).value("")
        else
          e.section.item(:j_pace).value((jinken_total.to_f/pace_nisu*loopcnt).round(0))
          e.section.item(:u_pace).value((uriage_total.to_f/pace_nisu*loopcnt).round(0))
          if jinken_total.to_i == 0
            e.section.item(:win_pace).value(0)
          else
            e.section.item(:win_pace).value(((uriage_total.to_i-jinken_total.to_i).to_f/pace_nisu*loopcnt).round(0))
          end
        end
        
        
      end #events.on
    end #list


    #ページ番号、タイトル、作成日セット  
    #title1 = ""
    #title2 = ""
      
    #ページ、作成日、タイトル設定
    #report.events.on :page_create do |e|
    #  e.page.item(:page).value(e.page.no)
    #  e.page.item(:sakusei_ymd).value(Time.now.strftime("%Y-%m-%d"))
    #  e.page.item(:title1).value(title1)
    #  e.page.item(:title2).value(title2)
    #end #evants.on
    
    report.start_new_page
 
    #ヘッダー
    report.page.list(:list).header do |h|
        output_ym = @head[:input_day].to_s[0,4].to_i.to_s + "年" + @head[:input_day].to_s[4,2].to_i.to_s + "月"
        h.item(:output_ym).value(output_ym)
        h.item(:shop_name).value(@m_shop.shop_name)
        
        if @m_shop.shop_kbn == 0
          h.item(:u_label).value("洗車目標")
          d_aim_uriage = DAim.find(:first, :conditions=>["date = ? and m_shop_id = ? and m_aim_id = 2", @head[:input_day].to_s[0,6], @m_shop.id])
          d_aim_jinken = DAim.find(:first, :conditions=>["date = ? and m_shop_id = ? and m_aim_id = 22", @head[:input_day].to_s[0,6], @m_shop.id])
        else
          h.item(:u_label).value("油外目標")
          d_aim_uriage = DAim.find(:first, :conditions=>["date = ? and m_shop_id = ? and m_aim_id = 1", @head[:input_day].to_s[0,6], @m_shop.id])
          d_aim_jinken = DAim.find(:first, :conditions=>["date = ? and m_shop_id = ? and m_aim_id = 23", @head[:input_day].to_s[0,6], @m_shop.id])
        end
        
        d_aim_uriage = DAim.new if d_aim_uriage.blank?
        d_aim_jinken = DAim.new if d_aim_jinken.blank?

        y_sisu = (d_aim_jinken.aim_total.to_i == 0 ? 0: (d_aim_uriage.aim_total.to_i*10000).to_f / (d_aim_jinken.aim_total.to_i*10000).to_f * 100).round
        
        if @m_shop.shop_kbn == 0
          h.item(:u_aim).value(d_aim_uriage.aim_total.to_i*10000)
          h.item(:j_aim).value(d_aim_jinken.aim_total.to_i*10000)
        else
          h.item(:u_aim).value(d_aim_uriage.aim_total)
          h.item(:j_aim).value(d_aim_jinken.aim_total)
        end
        h.item(:y_sisu).value(y_sisu)
        loopcnt.times do |i|
          select_day = Date.new(@head[:input_day].to_s[0,4].to_i, @head[:input_day].to_s[4,2].to_i, i + 1)    
          week_w = day_of_the_week(select_day.wday) 
          h.item("d_#{i+1}").value(i+1)
          h.item("w_#{i+1}").value(week_w)
          if @m_shop.shop_kbn == 0
            h.item("u_aim_#{i+1}").value(d_aim_uriage["aim_value#{i+1}"].to_i*10000)
            h.item("j_aim_#{i+1}").value(d_aim_jinken["aim_value#{i+1}"].to_i*10000)
          else
            h.item("u_aim_#{i+1}").value(d_aim_uriage["aim_value#{i+1}"])
            h.item("j_aim_#{i+1}").value(d_aim_jinken["aim_value#{i+1}"])
          end
          y_sisu_n = (d_aim_jinken["aim_value#{i+1}"].to_i == 0 ? 0 : (d_aim_uriage["aim_value#{i+1}"].to_i*10000).to_f  / (d_aim_jinken["aim_value#{i+1}"].to_i*10000).to_f  * 100).round
          h.item("y_sisu_#{i+1}").value(y_sisu_n)
        end 
    end
    
    # 詳細作成
    #社員繰り返し
    users = get_user_dutry("0,4", @m_shop_id, @head[:input_day].to_s[0,4], @head[:input_day].to_s[4,2], 1, loopcnt)
    users.each_with_index do |user,idx|
      
      if @from_view == 'syoukai_menu'
        select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and kakutei_flg = 1 "
      else
        select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and input_flg = 1 "
      end
      
      d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
    
    # Set header datas.
      if idx == 0
        report.page.list(:list).add_row do |row|
          row.item("user_name").value("名前")
          row.item("ruikei").value("累計")
        end #add_row
      end
    
      report.page.list(:list).add_row do |row|
        row.item("user_name").value(user.user_name)
        
        if @from_view == 'syoukai_menu'
          select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and kakutei_flg = 1 "
        else
          select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and input_flg = 1 "
        end
        
        row.item("ruikei").value(d_duty_syain_total(select_where, "money")[0].all_money)
        jinken_total = jinken_total.to_i + d_duty_syain_total(select_where, "money")[0].all_money.to_i
        
        unless d_duties.blank?
          n = 0
          loopcnt.times do |i|
            unless d_duties[n].blank?
              if d_duties[n].day == (i + 1)
                
                if @head_output_kbn == 1
                  #金額表示
                  row.item("j_#{i+1}").value(d_duties[n].all_money)
                else
                  #勤怠表示
                  if d_duties[n].day_work_time.to_i == 1
                    row.item("j_#{i+1}").value("出")
                  else
                    row.item("j_#{i+1}").value("休")
                  end
                  row.item("j_#{i+1}").style(:align,:center) #テキストの位置（横位置）
                end
                jinken[i+1] = jinken[i+1].to_i + d_duties[n].all_money.to_i
                n += 1
              end
            end
          end
        end
         
      end #add_row
      
      #最終行に空白行を作成
      if users.count == (idx+1)
        report.page.list(:list).add_row do |row|
          row.item("user_name").value("")
          row.item("ruikei").value("")
        end
      end
      
    end # users.each
    
    #バイト繰り返し
    users = get_user_dutry(1, @m_shop_id, @head[:input_day].to_s[0,4], @head[:input_day].to_s[4,2], 1, loopcnt)
    users.each_with_index do |user,idx|
      
      if @from_view == 'syoukai_menu'
        select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and kakutei_flg = 1 "
      else
        select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and input_flg = 1 "
      end
      
      d_duties = DDuty.find(:all, :conditions=>["#{select_where}"], :order => "day")
      
    # Set header datas.
      if idx == 0
        report.page.list(:list).add_row do |row|
          row.item("user_name").value("名前")
          row.item("ruikei").value("累計")
        end #add_row
      end
    
      report.page.list(:list).add_row do |row|
        row.item("user_name").value(user.user_name)
        
        if @from_view == 'syoukai_menu'
          select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and kakutei_flg = 1 "
        else
          select_where = " duty_nengetu = '#{@head[:input_day].to_s[0,6]}' and user_id = #{user.id} and input_flg = 1 "
        end
        
        row.item("ruikei").value(d_duty_baito_total(select_where, "money")[0].all_money)
        jinken_total = jinken_total.to_i + d_duty_baito_total(select_where, "money")[0].all_money.to_i
        
        unless d_duties.blank?
          n = 0
          loopcnt.times do |i|
            unless d_duties[n].blank?
              if d_duties[n].day == (i + 1)
                
                if @head_output_kbn == 1
                  #金額表示
                  row.item("j_#{i+1}").value(d_duties[n].all_money)
                else
                  #勤怠表示
                  if d_duties[n].all_work_time.to_f > 0
                    row.item("j_#{i+1}").value(d_duties[n].all_work_time)
                  else
                    row.item("j_#{i+1}").value("")
                  end
                end
                jinken[i+1] = jinken[i+1].to_i + d_duties[n].all_money.to_i
                n += 1
              end
            end
          end
        end 
        
      end #add_row
      
      #最終行に空白行を作成
      if users.count == (idx+1)
        report.page.list(:list).add_row do |row|
          row.item("user_name").value("")
          row.item("ruikei").value("")
        end
      end
      
    end # users.each
    
    output_day_cnt, output_day = get_d_duty_output_day(@head[:input_day].to_s[0,6], @m_shop.id ) 
    select_where = " result_date in(#{output_day}) and m_shop_id = #{@m_shop.id} "

    #フッター用合計データ作成
    if @m_shop.shop_kbn == 0
      u_total_label = "洗車売上合計"
      u_pace_label = "洗車ペース"
      
      #select_where = " result_date between '#{@head[:input_day].to_s[0,6]}01' and '#{@head[:input_day].to_s[0,6]}32' and m_shop_id = #{@m_shop.id} "
      d_result_self_report = DResultSelfReport.find_by_sql("select b.result_date, a.* from d_result_self_reports a inner join d_results b on a.d_result_id = b.id where #{select_where} order by result_date")
      
      #select_where = " result_date between '#{@head[:input_day].to_s[0,6]}01' and '#{@head[:input_day].to_s[0,6]}32' and m_shop_id = #{@m_shop.id} "
      uriage_total = uriage_total.to_i + d_result_total_sensya(select_where)[0].sensya.to_i
      
      unless d_result_self_report.blank?
        n = 0
        loopcnt.times do |i|
          unless d_result_self_report[n].blank?
            if d_result_self_report[n].result_date.to_s[6,2].to_i == (i + 1)
              uriage[i+1] = uriage[i+1].to_i + d_result_self_report[n].sensya.to_i
              n += 1
            end
          end
        end
      end
      
    else
      u_total_label = "油外売上合計"
      u_pace_label = "油外ペース"
      
      #select_where = " result_date between '#{@head[:input_day].to_s[0,6]}01' and '#{@head[:input_day].to_s[0,6]}32' and m_shop_id = #{@m_shop.id} "
      d_result_report = DResultReport.find_by_sql("select b.result_date, a.* from d_result_reports a inner join d_results b on a.d_result_id = b.id where #{select_where} order by result_date")
      
      #select_where = " result_date between '#{@head[:input_day].to_s[0,6]}01' and '#{@head[:input_day].to_s[0,6]}32' and m_shop_id = #{@m_shop.id} "
      uriage_total = uriage_total.to_i + d_result_total_yugai(select_where)[0].arari.to_i
      
      unless d_result_report.blank?
        n = 0
        loopcnt.times do |i|
          unless d_result_report[n].blank?
            if d_result_report[n].result_date.to_s[6,2].to_i == (i + 1)
              uriage[i+1] = uriage[i+1].to_i + d_result_report[n].arari.to_i
              n += 1
            end
          end
        end
      end
      
    end
    
    pdf_title_ym = @head[:input_day].to_s[0,4].to_i.to_s + "年" + @head[:input_day].to_s[4,2].to_i.to_s + "月分"
    #ファイル名セット     
    if @head_output_kbn == 1
      pdf_title = "人件費表(金額)_#{pdf_title_ym}.pdf"
    else
      pdf_title = "人件費表(勤怠)_#{pdf_title_ym}.pdf"
    end
    ua = request.env["HTTP_USER_AGENT"]
    pdf_title = URI.encode(pdf_title) if ua.include?('MSIE') #InternetExproler対応
      
    #pdfを作成
    send_data report.generate, :filename    => pdf_title ,#URI.encode(pdf_title), #KOWA IEでファイルをダウンロードすると文字化けするため
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
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
