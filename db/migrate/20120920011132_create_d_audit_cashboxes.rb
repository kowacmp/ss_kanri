# -*- coding:utf-8 -*-
class CreateDAuditCashboxes < ActiveRecord::Migration
  def change
    create_table :d_audit_cashboxes do |t|

      t.string  :audit_date,           :limit => 8,   :null => false
      t.integer :audit_class,          :null => false
      t.integer :m_shop_id,            :null => false
      t.integer :kakutei_flg,          :null => false
      
      t.integer :cashbox1,             :defalut => 0
      t.integer :cashbox1_10000paper,  :defalut => 0
      t.integer :cashbox1_5000paper,   :defalut => 0
      t.integer :cashbox1_1000paper,   :defalut => 0
      t.integer :cashbox1_500coin_50,  :defalut => 0
      t.integer :cashbox1_500coin_20,  :defalut => 0
      t.integer :cashbox1_500coin_mai, :defalut => 0
      t.integer :cashbox1_100coin_hon, :defalut => 0
      t.integer :cashbox1_100coin_mai, :defalut => 0
      t.integer :cashbox1_50coin_hon,  :defalut => 0
      t.integer :cashbox1_50coin_mai,  :defalut => 0      
      t.integer :cashbox1_10coin_hon,  :defalut => 0
      t.integer :cashbox1_10coin_mai,  :defalut => 0  
      t.integer :cashbox1_5coin_hon,   :defalut => 0
      t.integer :cashbox1_5coin_mai,   :defalut => 0  
      t.integer :cashbox1_1coin_hon,   :defalut => 0
      t.integer :cashbox1_1coin_mai,   :defalut => 0  
      t.integer :cashbox1_yobi,        :defalut => 0
      t.integer :cashbox1_still1,      :defalut => 0
      t.integer :cashbox1_still2,      :defalut => 0
      t.integer :cashbox1_still3,      :defalut => 0
      t.integer :cashbox1_still4,      :defalut => 0
      t.integer :cashbox1_still5,      :defalut => 0
      
      t.integer :cashbox2,             :defalut => 0
      t.integer :cashbox2_10000paper,  :defalut => 0
      t.integer :cashbox2_5000paper,   :defalut => 0
      t.integer :cashbox2_1000paper,   :defalut => 0
      t.integer :cashbox2_500coin_50,  :defalut => 0
      t.integer :cashbox2_500coin_20,  :defalut => 0
      t.integer :cashbox2_500coin_mai, :defalut => 0
      t.integer :cashbox2_100coin_hon, :defalut => 0
      t.integer :cashbox2_100coin_mai, :defalut => 0
      t.integer :cashbox2_50coin_hon,  :defalut => 0
      t.integer :cashbox2_50coin_mai,  :defalut => 0      
      t.integer :cashbox2_10coin_hon,  :defalut => 0
      t.integer :cashbox2_10coin_mai,  :defalut => 0  
      t.integer :cashbox2_5coin_hon,   :defalut => 0
      t.integer :cashbox2_5coin_mai,   :defalut => 0  
      t.integer :cashbox2_1coin_hon,   :defalut => 0
      t.integer :cashbox2_1coin_mai,   :defalut => 0  
      t.integer :cashbox2_yobi,        :defalut => 0
      t.integer :cashbox2_still1,      :defalut => 0
      t.integer :cashbox2_still2,      :defalut => 0
      t.integer :cashbox2_still3,      :defalut => 0
      t.integer :cashbox2_still4,      :defalut => 0
      t.integer :cashbox2_still5,      :defalut => 0
      
      t.integer :cashbox3,             :defalut => 0
      t.integer :cashbox3_10000paper,  :defalut => 0
      t.integer :cashbox3_5000paper,   :defalut => 0
      t.integer :cashbox3_1000paper,   :defalut => 0
      t.integer :cashbox3_500coin_50,  :defalut => 0
      t.integer :cashbox3_500coin_20,  :defalut => 0
      t.integer :cashbox3_500coin_mai, :defalut => 0
      t.integer :cashbox3_100coin_hon, :defalut => 0
      t.integer :cashbox3_100coin_mai, :defalut => 0
      t.integer :cashbox3_50coin_hon,  :defalut => 0
      t.integer :cashbox3_50coin_mai,  :defalut => 0      
      t.integer :cashbox3_10coin_hon,  :defalut => 0
      t.integer :cashbox3_10coin_mai,  :defalut => 0  
      t.integer :cashbox3_5coin_hon,   :defalut => 0
      t.integer :cashbox3_5coin_mai,   :defalut => 0  
      t.integer :cashbox3_1coin_hon,   :defalut => 0
      t.integer :cashbox3_1coin_mai,   :defalut => 0  
      t.integer :cashbox3_yobi,        :defalut => 0
      t.integer :cashbox3_still1,      :defalut => 0
      t.integer :cashbox3_still2,      :defalut => 0
      t.integer :cashbox3_still3,      :defalut => 0
      t.integer :cashbox3_still4,      :defalut => 0
      t.integer :cashbox3_still5,      :defalut => 0      
      
      t.integer :cashbox4,             :defalut => 0
      t.integer :cashbox4_10000paper,  :defalut => 0
      t.integer :cashbox4_5000paper,   :defalut => 0
      t.integer :cashbox4_1000paper,   :defalut => 0
      t.integer :cashbox4_500coin_50,  :defalut => 0
      t.integer :cashbox4_500coin_20,  :defalut => 0
      t.integer :cashbox4_500coin_mai, :defalut => 0
      t.integer :cashbox4_100coin_hon, :defalut => 0
      t.integer :cashbox4_100coin_mai, :defalut => 0
      t.integer :cashbox4_50coin_hon,  :defalut => 0
      t.integer :cashbox4_50coin_mai,  :defalut => 0      
      t.integer :cashbox4_10coin_hon,  :defalut => 0
      t.integer :cashbox4_10coin_mai,  :defalut => 0  
      t.integer :cashbox4_5coin_hon,   :defalut => 0
      t.integer :cashbox4_5coin_mai,   :defalut => 0  
      t.integer :cashbox4_1coin_hon,   :defalut => 0
      t.integer :cashbox4_1coin_mai,   :defalut => 0  
      t.integer :cashbox4_yobi,        :defalut => 0
      t.integer :cashbox4_still1,      :defalut => 0
      t.integer :cashbox4_still2,      :defalut => 0
      t.integer :cashbox4_still3,      :defalut => 0
      t.integer :cashbox4_still4,      :defalut => 0
      t.integer :cashbox4_still5,      :defalut => 0

      t.integer :cashbox5,             :defalut => 0
      t.integer :cashbox5_10000paper,  :defalut => 0
      t.integer :cashbox5_5000paper,   :defalut => 0
      t.integer :cashbox5_1000paper,   :defalut => 0
      t.integer :cashbox5_500coin_50,  :defalut => 0
      t.integer :cashbox5_500coin_20,  :defalut => 0
      t.integer :cashbox5_500coin_mai, :defalut => 0
      t.integer :cashbox5_100coin_hon, :defalut => 0
      t.integer :cashbox5_100coin_mai, :defalut => 0
      t.integer :cashbox5_50coin_hon,  :defalut => 0
      t.integer :cashbox5_50coin_mai,  :defalut => 0      
      t.integer :cashbox5_10coin_hon,  :defalut => 0
      t.integer :cashbox5_10coin_mai,  :defalut => 0  
      t.integer :cashbox5_5coin_hon,   :defalut => 0
      t.integer :cashbox5_5coin_mai,   :defalut => 0  
      t.integer :cashbox5_1coin_hon,   :defalut => 0
      t.integer :cashbox5_1coin_mai,   :defalut => 0  
      t.integer :cashbox5_yobi,        :defalut => 0
      t.integer :cashbox5_still1,      :defalut => 0
      t.integer :cashbox5_still2,      :defalut => 0
      t.integer :cashbox5_still3,      :defalut => 0
      t.integer :cashbox5_still4,      :defalut => 0
      t.integer :cashbox5_still5,      :defalut => 0

      t.integer :cashbox6,             :defalut => 0
      t.integer :cashbox6_10000paper,  :defalut => 0
      t.integer :cashbox6_5000paper,   :defalut => 0
      t.integer :cashbox6_1000paper,   :defalut => 0
      t.integer :cashbox6_500coin_50,  :defalut => 0
      t.integer :cashbox6_500coin_20,  :defalut => 0
      t.integer :cashbox6_500coin_mai, :defalut => 0
      t.integer :cashbox6_100coin_hon, :defalut => 0
      t.integer :cashbox6_100coin_mai, :defalut => 0
      t.integer :cashbox6_50coin_hon,  :defalut => 0
      t.integer :cashbox6_50coin_mai,  :defalut => 0      
      t.integer :cashbox6_10coin_hon,  :defalut => 0
      t.integer :cashbox6_10coin_mai,  :defalut => 0  
      t.integer :cashbox6_5coin_hon,   :defalut => 0
      t.integer :cashbox6_5coin_mai,   :defalut => 0  
      t.integer :cashbox6_1coin_hon,   :defalut => 0
      t.integer :cashbox6_1coin_mai,   :defalut => 0  
      t.integer :cashbox6_yobi,        :defalut => 0
      t.integer :cashbox6_still1,      :defalut => 0
      t.integer :cashbox6_still2,      :defalut => 0
      t.integer :cashbox6_still3,      :defalut => 0
      t.integer :cashbox6_still4,      :defalut => 0
      t.integer :cashbox6_still5,      :defalut => 0

      t.integer :sum1_cashbox, :defalut => 0
      t.integer :sum1_money,   :defalut => 0
      t.integer :sum1_still1,  :defalut => 0 
      t.integer :sum1_still2,  :defalut => 0 
      t.integer :sum1_still3,  :defalut => 0 
      t.integer :sum1_still4,  :defalut => 0 
      t.integer :sum1_still5,  :defalut => 0 

      t.integer :sum2_cashbox, :defalut => 0
      t.integer :sum2_money,   :defalut => 0
      t.integer :sum2_still1,  :defalut => 0 
      t.integer :sum2_still2,  :defalut => 0 
      t.integer :sum2_still3,  :defalut => 0 
      t.integer :sum2_still4,  :defalut => 0 
      t.integer :sum2_still5,  :defalut => 0 

      t.integer :sum3_cashbox, :defalut => 0
      t.integer :sum3_money,   :defalut => 0
      t.integer :sum3_still1,  :defalut => 0 
      t.integer :sum3_still2,  :defalut => 0 
      t.integer :sum3_still3,  :defalut => 0 
      t.integer :sum3_still4,  :defalut => 0 
      t.integer :sum3_still5,  :defalut => 0 

      t.integer :sum4_cashbox, :defalut => 0
      t.integer :sum4_money,   :defalut => 0
      t.integer :sum4_still1,  :defalut => 0 
      t.integer :sum4_still2,  :defalut => 0 
      t.integer :sum4_still3,  :defalut => 0 
      t.integer :sum4_still4,  :defalut => 0 
      t.integer :sum4_still5,  :defalut => 0 

      t.integer :sum5_cashbox, :defalut => 0
      t.integer :sum5_money,   :defalut => 0
      t.integer :sum5_still1,  :defalut => 0 
      t.integer :sum5_still2,  :defalut => 0 
      t.integer :sum5_still3,  :defalut => 0 
      t.integer :sum5_still4,  :defalut => 0 
      t.integer :sum5_still5,  :defalut => 0 
      
      t.integer :sum6_cashbox, :defalut => 0
      t.integer :sum6_money,   :defalut => 0
      t.integer :sum6_still1,  :defalut => 0 
      t.integer :sum6_still2,  :defalut => 0 
      t.integer :sum6_still3,  :defalut => 0 
      t.integer :sum6_still4,  :defalut => 0 
      t.integer :sum6_still5,  :defalut => 0 
      
      t.integer :sum7_cashbox, :defalut => 0
      t.integer :sum7_money,   :defalut => 0
      t.integer :sum7_still1,  :defalut => 0 
      t.integer :sum7_still2,  :defalut => 0 
      t.integer :sum7_still3,  :defalut => 0 
      t.integer :sum7_still4,  :defalut => 0 
      t.integer :sum7_still5,  :defalut => 0 
      
      t.integer :ledger1,        :defalut => 0
      t.string    :ledger1_reason, :limit => 20
      
      t.integer :ledger2,        :defalut => 0
      t.string    :ledger2_reason, :limit => 20
     
      t.integer :ledger3,        :defalut => 0
      t.string    :ledger3_reason, :limit => 20
      
      t.integer :ledger4,        :defalut => 0
      t.string    :ledger4_reason, :limit => 20
      
      t.integer :ledger5,        :defalut => 0
      t.string    :ledger5_reason, :limit => 20
      
      t.integer :confirm_shop_id, :defalut => 0
      t.integer :confirm_user_id, :defalut => 0
      
      t.string    :comment, :limit => 200
      
      t.integer    :kakunin_flg
      t.integer    :kakunin_user_id
      t.timestamp  :kakunin_date
      t.integer    :approve_id1
      t.timestamp  :approve_date1
      t.integer    :approve_id2
      t.timestamp  :approve_date2
      t.integer    :approve_id3
      t.timestamp  :approve_date3
      t.integer    :approve_id4
      t.timestamp  :approve_date4
      t.integer    :approve_id5
      t.timestamp  :approve_date5
      
      t.integer    :created_user_id, :defalut => 0, :null => false
      t.integer    :updated_user_id, :defalut => 0, :null => false
      
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.audit_date  IS '監査日';"
    execute "COMMENT ON COLUMN d_audit_cashboxes.audit_class IS '監査種別';"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.m_shop_id   IS '店舗id';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.kakutei_flg IS '確定フラグ';"     
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1             IS '金庫1指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_10000paper  IS '金庫1_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_5000paper   IS '金庫1_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_1000paper   IS '金庫1_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_500coin_50  IS '金庫1_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_500coin_20  IS '金庫1_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_500coin_mai IS '金庫1_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_100coin_hon IS '金庫1_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_100coin_mai IS '金庫1_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_50coin_hon  IS '金庫1_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_50coin_mai  IS '金庫1_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_10coin_hon  IS '金庫1_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_10coin_mai  IS '金庫1_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_5coin_hon   IS '金庫1_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_5coin_mai   IS '金庫1_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_1coin_hon   IS '金庫1_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_1coin_mai   IS '金庫1_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_yobi        IS '金庫1_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_still1      IS '金庫1_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_still2      IS '金庫1_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_still3      IS '金庫1_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_still4      IS '金庫1_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox1_still5      IS '金庫1_未立替5'"  
 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2             IS '金庫2指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_10000paper  IS '金庫2_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_5000paper   IS '金庫2_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_1000paper   IS '金庫2_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_500coin_50  IS '金庫2_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_500coin_20  IS '金庫2_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_500coin_mai IS '金庫2_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_100coin_hon IS '金庫2_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_100coin_mai IS '金庫2_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_50coin_hon  IS '金庫2_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_50coin_mai  IS '金庫2_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_10coin_hon  IS '金庫2_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_10coin_mai  IS '金庫2_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_5coin_hon   IS '金庫2_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_5coin_mai   IS '金庫2_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_1coin_hon   IS '金庫2_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_1coin_mai   IS '金庫2_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_yobi        IS '金庫2_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_still1      IS '金庫2_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_still2      IS '金庫2_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_still3      IS '金庫2_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_still4      IS '金庫2_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox2_still5      IS '金庫2_未立替5'"   
 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3             IS '金庫3指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_10000paper  IS '金庫3_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_5000paper   IS '金庫3_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_1000paper   IS '金庫3_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_500coin_50  IS '金庫3_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_500coin_20  IS '金庫3_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_500coin_mai IS '金庫3_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_100coin_hon IS '金庫3_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_100coin_mai IS '金庫3_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_50coin_hon  IS '金庫3_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_50coin_mai  IS '金庫3_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_10coin_hon  IS '金庫3_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_10coin_mai  IS '金庫3_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_5coin_hon   IS '金庫3_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_5coin_mai   IS '金庫3_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_1coin_hon   IS '金庫3_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_1coin_mai   IS '金庫3_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_yobi        IS '金庫3_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_still1      IS '金庫3_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_still2      IS '金庫3_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_still3      IS '金庫3_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_still4      IS '金庫3_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox3_still5      IS '金庫3_未立替5'"  
 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4             IS '金庫4指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_10000paper  IS '金庫4_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_5000paper   IS '金庫4_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_1000paper   IS '金庫4_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_500coin_50  IS '金庫4_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_500coin_20  IS '金庫4_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_500coin_mai IS '金庫4_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_100coin_hon IS '金庫4_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_100coin_mai IS '金庫4_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_50coin_hon  IS '金庫4_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_50coin_mai  IS '金庫4_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_10coin_hon  IS '金庫4_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_10coin_mai  IS '金庫4_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_5coin_hon   IS '金庫4_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_5coin_mai   IS '金庫4_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_1coin_hon   IS '金庫4_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_1coin_mai   IS '金庫4_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_yobi        IS '金庫4_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_still1      IS '金庫4_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_still2      IS '金庫4_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_still3      IS '金庫4_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_still4      IS '金庫4_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox4_still5      IS '金庫4_未立替5'"  
 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5             IS '金庫5指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_10000paper  IS '金庫5_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_5000paper   IS '金庫5_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_1000paper   IS '金庫5_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_500coin_50  IS '金庫5_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_500coin_20  IS '金庫5_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_500coin_mai IS '金庫5_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_100coin_hon IS '金庫5_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_100coin_mai IS '金庫5_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_50coin_hon  IS '金庫5_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_50coin_mai  IS '金庫5_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_10coin_hon  IS '金庫5_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_10coin_mai  IS '金庫5_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_5coin_hon   IS '金庫5_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_5coin_mai   IS '金庫5_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_1coin_hon   IS '金庫5_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_1coin_mai   IS '金庫5_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_yobi        IS '金庫5_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_still1      IS '金庫5_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_still2      IS '金庫5_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_still3      IS '金庫5_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_still4      IS '金庫5_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox5_still5      IS '金庫5_未立替5'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6             IS '金庫6指定額';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_10000paper  IS '金庫6_1万円札';"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_5000paper   IS '金庫6_5千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_1000paper   IS '金庫6_1千円札';" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_500coin_50  IS '金庫6_500円50本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_500coin_20  IS '金庫6_500円20本'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_500coin_mai IS '金庫6_500円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_100coin_hon IS '金庫6_100円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_100coin_mai IS '金庫6_100円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_50coin_hon  IS '金庫6_50円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_50coin_mai  IS '金庫6_50円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_10coin_hon  IS '金庫6_10円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_10coin_mai  IS '金庫6_10円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_5coin_hon   IS '金庫6_5円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_5coin_mai   IS '金庫6_5円枚'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_1coin_hon   IS '金庫6_1円本'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_1coin_mai   IS '金庫6_1円枚'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_yobi        IS '金庫6_予備'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_still1      IS '金庫6_未立替1'"  
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_still2      IS '金庫6_未立替2'"   
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_still3      IS '金庫6_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_still4      IS '金庫6_未立替4'"     
    execute "COMMENT ON COLUMN d_audit_cashboxes.cashbox6_still5      IS '金庫6_未立替5'"  
 
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_cashbox         IS '一括金庫1指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_money           IS '一括金庫1金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_still1          IS '一括金庫1_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_still2          IS '一括金庫1_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_still3          IS '一括金庫1_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_still4          IS '一括金庫1_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum1_still5          IS '一括金庫1_未立替5'"

    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_cashbox         IS '一括金庫2指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_money           IS '一括金庫2金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_still1          IS '一括金庫2_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_still2          IS '一括金庫2_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_still3          IS '一括金庫2_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_still4          IS '一括金庫2_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum2_still5          IS '一括金庫2_未立替5'"
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_cashbox         IS '一括金庫3指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_money           IS '一括金庫3金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_still1          IS '一括金庫3_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_still2          IS '一括金庫3_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_still3          IS '一括金庫3_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_still4          IS '一括金庫3_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum3_still5          IS '一括金庫3_未立替5'"     
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_cashbox         IS '一括金庫4指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_money           IS '一括金庫4金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_still1          IS '一括金庫4_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_still2          IS '一括金庫4_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_still3          IS '一括金庫4_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_still4          IS '一括金庫4_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum4_still5          IS '一括金庫4_未立替5'"
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_cashbox         IS '一括金庫5指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_money           IS '一括金庫5金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_still1          IS '一括金庫5_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_still2          IS '一括金庫5_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_still3          IS '一括金庫5_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_still4          IS '一括金庫5_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum5_still5          IS '一括金庫5_未立替5'"
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_cashbox         IS '一括金庫6指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_money           IS '一括金庫6金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_still1          IS '一括金庫6_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_still2          IS '一括金庫6_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_still3          IS '一括金庫6_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_still4          IS '一括金庫6_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum6_still5          IS '一括金庫6_未立替5'"
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_cashbox         IS '一括金庫7指定額'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_money           IS '一括金庫7金額'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_still1          IS '一括金庫7_未立替1'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_still2          IS '一括金庫7_未立替2'"    
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_still3          IS '一括金庫7_未立替3'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_still4          IS '一括金庫7_未立替4'"
    execute "COMMENT ON COLUMN d_audit_cashboxes.sum7_still5          IS '一括金庫7_未立替5'"
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1              IS '台帳管理1'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1_reason       IS '台帳管理1理由'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger2              IS '台帳管理2'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger2_reason       IS '台帳管理2理由'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger3              IS '台帳管理3'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger3_reason       IS '台帳管理3理由'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1              IS '台帳管理4'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1_reason       IS '台帳管理4理由'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1              IS '台帳管理5'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.ledger1_reason       IS '台帳管理5理由'" 
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.confirm_shop_id      IS '店舗id'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.confirm_user_id      IS '立会人id'" 
     
    execute "COMMENT ON COLUMN d_audit_cashboxes.kakunin_flg          IS '確認フラグ'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.kakunin_user_id      IS '確認者id'"      
    execute "COMMENT ON COLUMN d_audit_cashboxes.kakunin_date         IS '確認日'" 
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_id1          IS '承認者id1'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_date1        IS '承認日1'" 
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_id2          IS '承認者id2'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_date2        IS '承認日2'" 
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_id3          IS '承認者id3'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_date3        IS '承認日3'" 

    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_id4          IS '承認者id4'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_date4        IS '承認日4'" 
    
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_id5          IS '承認者id5'" 
    execute "COMMENT ON COLUMN d_audit_cashboxes.approve_date5        IS '承認日5'" 
    
  end
end
