# -*- coding:utf-8 -*-
class CreateMPriceChkNames < ActiveRecord::Migration
  def change
    create_table :m_price_chk_names do |t|

      t.string :price1_disp1, :limit => 10
      t.string :price1_item1, :limit => 10
      t.string :price1_item2, :limit => 10
      t.string :price1_item3, :limit => 10
      
      t.string :price2_disp1, :limit => 10
      t.string :price2_item1, :limit => 10
      t.string :price2_item2, :limit => 10
      t.string :price2_item3, :limit => 10
      
      t.integer   :deleted_flg, :default => 0
      t.timestamp :deleted_at
      
      t.timestamps
      
    end
    
    execute "
      COMMENT ON COLUMN m_price_chk_names.price1_disp1 IS '価格1表示大項目1(例,通常時)';
      COMMENT ON COLUMN m_price_chk_names.price1_item1 IS '価格1表示中項目1(例,サインポール)';
      COMMENT ON COLUMN m_price_chk_names.price1_item2 IS '価格1表示中項目2(例,下看)';
      COMMENT ON COLUMN m_price_chk_names.price1_item3 IS '価格1表示中項目3(例,通常価格)';
      COMMENT ON COLUMN m_price_chk_names.price2_disp1 IS '価格1表示大項目1(例,特価時)';
      COMMENT ON COLUMN m_price_chk_names.price2_item1 IS '価格1表示中項目1(例,サインポール)';
      COMMENT ON COLUMN m_price_chk_names.price2_item2 IS '価格1表示中項目2(例,下看)';
      COMMENT ON COLUMN m_price_chk_names.price2_item3 IS '価格1表示中項目3(例,特売価格)';
      COMMENT ON COLUMN m_price_chk_names.deleted_flg IS '削除フラグ';
    "
    execute "
      INSERT INTO m_price_chk_names (
         price1_disp1
        ,price1_item1
        ,price1_item2
        ,price1_item3
        ,price2_disp1
        ,price2_item1
        ,price2_item2
        ,price2_item3
        ,created_at
        ,updated_at
      ) VALUES (
          '通常時'
        , 'サインポール'
        , '下看'
        , '通常価格'
        , '特価時'
        , 'サインポール'
        , '下看'
        , '特売価格'
        , current_timestamp
        , current_timestamp
      );
    "
  end
end
