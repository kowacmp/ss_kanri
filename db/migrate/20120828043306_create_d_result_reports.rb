# -*- coding:utf-8 -*-
class CreateDResultReports < ActiveRecord::Migration
  def change
    create_table :d_result_reports do |t|
      t.integer :d_result_id,  :null => false
      t.decimal :mo_gas,     :precision => 10, :scale => 1
      t.decimal :keiyu,      :precision => 10, :scale => 1
      t.decimal :touyu,      :precision => 10, :scale => 1
      t.decimal :koua,       :precision => 5, :scale => 2
      t.integer :buyou
      t.integer :tokusei
      t.integer :sensya
      t.integer :koutin
      t.integer :taiya
      t.decimal :arari,      :precision => 10, :scale => 1
      t.integer :chousei
      t.integer :syaken
      t.integer :kyuyu_purika
      t.integer :sensya_purika
      t.integer :sp
      t.integer :sc
      t.integer :taiyaw
      t.integer :coating
      t.integer :atf
      t.integer :kousen
      t.integer :bt
      t.integer :bankin
      t.integer :waiper
      t.decimal :mobil1,     :precision => 4, :scale => 1
          
      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_result_reports.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_reports.mo_gas IS 'モーガス';
             COMMENT ON COLUMN d_result_reports.keiyu IS '軽油';
             COMMENT ON COLUMN d_result_reports.touyu IS '灯油';
             COMMENT ON COLUMN d_result_reports.koua IS 'オイル';
             COMMENT ON COLUMN d_result_reports.buyou IS '部用';
             COMMENT ON COLUMN d_result_reports.tokusei IS '特製';
             COMMENT ON COLUMN d_result_reports.sensya IS '洗車';
             COMMENT ON COLUMN d_result_reports.koutin IS '工賃';
             COMMENT ON COLUMN d_result_reports.taiya IS 'タイヤ';
             COMMENT ON COLUMN d_result_reports.arari IS '粗利';
             COMMENT ON COLUMN d_result_reports.chousei IS '調整';
             COMMENT ON COLUMN d_result_reports.syaken IS '車検';
             COMMENT ON COLUMN d_result_reports.kyuyu_purika IS '給油プリカ';
             COMMENT ON COLUMN d_result_reports.sensya_purika IS '洗車プリカ';
             COMMENT ON COLUMN d_result_reports.sp IS 'スピードパス';
             COMMENT ON COLUMN d_result_reports.sc IS 'シナジーカード';
             COMMENT ON COLUMN d_result_reports.taiyaw IS 'タイヤW';
             COMMENT ON COLUMN d_result_reports.coating IS 'コーティング';
             COMMENT ON COLUMN d_result_reports.atf IS 'ATF';
             COMMENT ON COLUMN d_result_reports.kousen IS '高額洗車';
             COMMENT ON COLUMN d_result_reports.bt IS 'バッテリー';
             COMMENT ON COLUMN d_result_reports.bankin IS '板金';
             COMMENT ON COLUMN d_result_reports.waiper IS 'ワイパー';
             COMMENT ON COLUMN d_result_reports.mobil1 IS 'モービル1';
     "
    
  end
end
