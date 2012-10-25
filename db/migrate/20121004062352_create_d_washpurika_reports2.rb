# -*- coding:utf-8 -*-
class CreateDWashpurikaReports2 < ActiveRecord::Migration
 def change
     create_table :d_washpurika_reports do |t|
      t.string   :date,               :null => false , :limit => 6 
      t.integer  :m_shop_id,          :null => false
      t.integer  :total_rank,         :null => false
      t.integer  :before_league,      :null => false
      t.integer  :league,             :null => false
      t.integer  :before_rank,        :null => false
      t.integer  :rank,               :null => false
      t.integer  :before_total_point, :default => 0  
      t.integer  :total_point,        :default => 0                
      t.integer  :result1          
      t.integer  :result2          
      t.integer  :result3          
      t.integer  :result4         
      t.integer  :result5         
      t.integer  :result6         
      t.integer  :result7         
      t.integer  :result8         
      t.integer  :result9         
      t.integer  :result10        
      t.integer  :result11        
      t.integer  :result12        
      t.integer  :result13        
      t.integer  :result14        
      t.integer  :result15        
      t.integer  :result16        
      t.integer  :result17        
      t.integer  :result18        
      t.integer  :result19        
      t.integer  :result20        
      t.integer  :result21        
      t.integer  :result22        
      t.integer  :result23        
      t.integer  :result24        
      t.integer  :result25        
      t.integer  :result26        
      t.integer  :result27        
      t.integer  :result28        
      t.integer  :result29        
      t.integer  :result30        
      t.integer  :result31        
      t.integer  :result_total,    :default => 0
      t.integer  :uriage1                
      t.integer  :uriage2           
      t.integer  :uriage3              
      t.integer  :uriage4         
      t.integer  :uriage5         
      t.integer  :uriage6         
      t.integer  :uriage7         
      t.integer  :uriage8         
      t.integer  :uriage9        
      t.integer  :uriage10       
      t.integer  :uriage11       
      t.integer  :uriage12       
      t.integer  :uriage13       
      t.integer  :uriage14       
      t.integer  :uriage15       
      t.integer  :uriage16       
      t.integer  :uriage17       
      t.integer  :uriage18        
      t.integer  :uriage19        
      t.integer  :uriage20        
      t.integer  :uriage21        
      t.integer  :uriage22        
      t.integer  :uriage23        
      t.integer  :uriage24        
      t.integer  :uriage25        
      t.integer  :uriage26        
      t.integer  :uriage27        
      t.integer  :uriage28        
      t.integer  :uriage29        
      t.integer  :uriage30        
      t.integer  :uriage31         
      t.integer  :uriage_total,          :default => 0
      t.integer  :pace,                  :default => 0
      t.integer  :same_pace,             :default => 0
      t.integer  :same_uriage,           :default => 0
      t.integer  :same_uriage_total,     :default => 0    
      t.integer  :same_uriage_total_max, :default => 0
      t.integer  :created_user_id
      t.integer  :updated_user_id
      t.timestamps
    end

    execute "COMMENT ON COLUMN d_washpurika_reports.date         IS '年月'"
    execute "COMMENT ON COLUMN d_washpurika_reports.m_shop_id    IS '店舗ID'"
    execute "COMMENT ON COLUMN d_washpurika_reports.total_rank   IS '総合順位'"
    execute "COMMENT ON COLUMN d_washpurika_reports.before_league IS '今月始リーグ'"
    execute "COMMENT ON COLUMN d_washpurika_reports.league        IS '今月末リーグ'"
    execute "COMMENT ON COLUMN d_washpurika_reports.before_rank   IS '今月始リーグ内順位'"
    execute "COMMENT ON COLUMN d_washpurika_reports.rank          IS '今月末リーグ内順位'"
    execute "COMMENT ON COLUMN d_washpurika_reports.before_total_point IS '今月始獲得pt'"
    execute "COMMENT ON COLUMN d_washpurika_reports.total_point        IS '今月末獲得pt'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result1      IS '実績枚数1'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result2      IS '実績枚数2'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result3      IS '実績枚数3'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result4      IS '実績枚数4'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result5      IS '実績枚数5'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result6      IS '実績枚数6'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result7      IS '実績枚数7'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result8      IS '実績枚数8'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result9      IS '実績枚数9'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result10     IS '実績枚数10'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result11     IS '実績枚数11'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result12     IS '実績枚数12'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result13     IS '実績枚数13'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result14     IS '実績枚数14'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result15     IS '実績枚数15'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result16     IS '実績枚数16'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result17     IS '実績枚数17'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result18     IS '実績枚数18'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result19     IS '実績枚数19'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result20     IS '実績枚数20'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result21     IS '実績枚数21'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result22     IS '実績枚数22'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result23     IS '実績枚数23'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result24     IS '実績枚数24'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result25     IS '実績枚数25'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result26     IS '実績枚数26'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result27     IS '実績枚数27'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result28     IS '実績枚数28'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result29     IS '実績枚数29'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result30     IS '実績枚数30'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result31     IS '実績枚数31'"
    execute "COMMENT ON COLUMN d_washpurika_reports.result_total IS '実績枚数計'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage1      IS '実績金額1'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage2      IS '実績金額2'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage3      IS '実績金額3'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage4      IS '実績金額4'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage5      IS '実績金額5'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage6      IS '実績金額6'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage7      IS '実績金額7'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage8      IS '実績金額8'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage9      IS '実績金額9'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage10     IS '実績金額10'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage11     IS '実績金額11'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage12     IS '実績金額12'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage13     IS '実績金額13'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage14     IS '実績金額14'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage15     IS '実績金額15'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage16     IS '実績金額16'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage17     IS '実績金額17'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage18     IS '実績金額18'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage19     IS '実績金額19'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage20     IS '実績金額20'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage21     IS '実績金額21'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage22     IS '実績金額22'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage23     IS '実績金額23'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage24     IS '実績金額24'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage25     IS '実績金額25'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage26     IS '実績金額26'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage27     IS '実績金額27'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage28     IS '実績金額28'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage29     IS '実績金額29'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage30     IS '実績金額30'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage31     IS '実績金額31'"
    execute "COMMENT ON COLUMN d_washpurika_reports.uriage_total IS '実績金額計'"    
    execute "COMMENT ON COLUMN d_washpurika_reports.pace         IS 'ペース'"   
    execute "COMMENT ON COLUMN d_washpurika_reports.same_pace    IS '前年同日迄のペース'"
    execute "COMMENT ON COLUMN d_washpurika_reports.same_uriage  IS '前年同日迄の実績金額計'"
    execute "COMMENT ON COLUMN d_washpurika_reports.same_uriage_total IS '前年同月末の実績金額計'"
    execute "COMMENT ON COLUMN d_washpurika_reports.same_uriage_total_max IS '同月末の最高実績金額計'"
    
  end
end
