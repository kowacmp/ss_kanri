class DSaleApprovesController < ApplicationController

  def index

    #処理なし
    
  end

  def edit

    # 処理選択よりメニューIDを取得する
    @menu_id = 1 #TODO:マスタを表示すること
    
    # 承認ID、及び名称を取得する
    @approval_id = 0
    @approval_name = ""
    m_approval = MApproval.find(:first, :conditions => ["menu_id=?", @menu_id])

    for i in 1..5 do
       if m_approval["apprpval_id#{i}"] = current_user.id then
         @approval_id   = i
         @approval_name = m_approval["apprpval_name#{i}"] 
       end
    end
    
    # 承認済を含むの条件を先に作る
    where_zumi = ""
    if params[:header][:zumi_flg].to_s != "1" then
      if @approval_id == 0 then
        where_zumi = "  
                       and coalesce(d_sale_reports.approve_id1, 0) = 0 
                       and coalesce(d_sale_reports.approve_id2, 0) = 0
                       and coalesce(d_sale_reports.approve_id3, 0) = 0
                       and coalesce(d_sale_reports.approve_id4, 0) = 0
                       and coalesce(d_sale_reports.approve_id5, 0) = 0 
                       
                     "    
      else
        where_zumi = "
                       and coalesce(d_sale_reports.approve_id#{@approval_id}, 0) = 0 
                     "  
      end
    end
    
    sql = "
      select
         d_sale_reports.id
        ,d_sale_reports.sale_date
        ,d_sale_reports.m_shop_id
        ,coalesce(d_sale_reports.approve_id1, 0) as approve_id1
        ,coalesce(d_sale_reports.approve_id2, 0) as approve_id2
        ,coalesce(d_sale_reports.approve_id3, 0) as approve_id3
        ,coalesce(d_sale_reports.approve_id4, 0) as approve_id4
        ,coalesce(d_sale_reports.approve_id5, 0) as approve_id5
        ,m_shops.shop_cd
        ,m_shops.shop_name   
        ,m_shops.shop_kbn
        ,d_sales_sum.exist_money
        ,d_sales_sum.over_short
      from 
        ( select 
              m_shop_id
             ,sum(exist_money) as exist_money
             ,sum(over_short)  as over_short
          from 
              d_sales
          where 
               sale_date >= '#{params[:header][:ym]}00'
           and sale_date <= '#{params[:header][:ym]}99'
          group by 
              m_shop_id
        ) as d_sales_sum
        
        inner join m_shops
           on d_sales_sum.m_shop_id = m_shops.id
           
        inner join d_sale_reports
           on d_sales_sum.m_shop_id = d_sale_reports.m_shop_id
           
      where 
            d_sale_reports.sale_date = '#{params[:header][:ym]}'
            #{ where_zumi }
      order by 
            m_shops.shop_cd
    
    "
    
    @approval = DSale.find_by_sql(sql)
    
  end
  
  def update
    
    #更新日時をバッファ
    upd_time = Time.now 

    #書込先の共通情報を取得
    approval_id = params[:approval][:approval_id]
    approval_name = params[:approval][:approval_name]

    #更新全体をトランザクション処理    
    DSaleReport.transaction {  

    i = 1
    until params["approval#{i}"].nil? do
      
      #1行分のを取得する
      approval = params["approval#{i}"]

      #チェックが変更されていたら書込する
      if to_boolean(approval[:old_approval_flg]) != to_boolean(approval[:approval_flg]) then
            
        rec = DSaleReport.find(approval[:id])
         
        if to_boolean(approval[:approval_flg]) then
          #ON
          rec["approve_id#{approval_id}"] = current_user.id
          rec["approve_date#{approval_id}"] = upd_time.to_date
        else
          #OFF
          rec["approve_id#{approval_id}"] = 0
          rec["approve_date#{approval_id}"] = nil
        end
      
        rec[:updated_user_id] = current_user.id
        rec[:updated_at] = upd_time
      
        rec.save!
        
      end
      
      i += 1
    
    end
    
    } #トランザクション終了
    
    # 再呼出
    redirect_to :action => "edit", :header => {:ym       => params[:header][:ym],
                                               :shop_kbn => params[:header][:shop_kbn],
                                               :zumi_flg => 0 }
    
  end
 
  private
  def to_boolean(obj)
    
    return (obj.to_s == "true" or obj.to_s == "1")
    
  end
  
end