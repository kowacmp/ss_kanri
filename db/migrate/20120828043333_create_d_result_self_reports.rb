# -*- coding:utf-8 -*-
class CreateDResultSelfReports < ActiveRecord::Migration
  def change
    create_table :d_result_self_reports do |t|
      t.integer :d_result_id,  :null => false
      t.decimal :mo_gas,     :precision => 10, :scale => 1
      t.decimal :keiyu,      :precision => 10, :scale => 1
      t.decimal :touyu,      :precision => 10, :scale => 1
      t.integer :kyuyu_purika
      t.integer :sensya
      t.integer :sensya_purika
      t.integer :muton
      t.integer :coating
      t.integer :taiyaw
      t.integer :sp
      t.integer :sc
      t.integer :wash_item
      t.integer :game
      t.integer :health
      t.integer :net
      t.integer :charge
      t.integer :spare
      
      t.timestamps
    end

    execute "COMMENT ON COLUMN d_result_self_reports.d_result_id IS '実績データid';
             COMMENT ON COLUMN d_result_self_reports.mo_gas IS 'モーガス';
             COMMENT ON COLUMN d_result_self_reports.keiyu IS '軽油';
             COMMENT ON COLUMN d_result_self_reports.touyu IS '灯油';
             COMMENT ON COLUMN d_result_self_reports.kyuyu_purika IS '給油プリカ';
             COMMENT ON COLUMN d_result_self_reports.sensya IS '洗車';
             COMMENT ON COLUMN d_result_self_reports.sensya_purika IS '洗車プリカ';
             COMMENT ON COLUMN d_result_self_reports.muton IS 'ムートンパス';
             COMMENT ON COLUMN d_result_self_reports.coating IS 'コーティング';
             COMMENT ON COLUMN d_result_self_reports.taiyaw IS 'タイヤW';
             COMMENT ON COLUMN d_result_self_reports.sp IS 'スピードパス';
             COMMENT ON COLUMN d_result_self_reports.sc IS 'シナジーカード';
             COMMENT ON COLUMN d_result_self_reports.wash_item IS '洗車用品';
             COMMENT ON COLUMN d_result_self_reports.game IS 'ゲーム';
             COMMENT ON COLUMN d_result_self_reports.health IS 'ヘルス';
             COMMENT ON COLUMN d_result_self_reports.net IS 'ネット';
             COMMENT ON COLUMN d_result_self_reports.charge IS '充電器';
             COMMENT ON COLUMN d_result_self_reports.spare IS '予備';
    "
    
  end
end
