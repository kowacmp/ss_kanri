# -*- coding:utf-8 -*-
class CreateDAims < ActiveRecord::Migration
  def change
    create_table :d_aims do |t|
      t.string  :date,            :limit => 6,      :null => false
      t.integer :m_shop_id,       :null => false
      t.integer :m_aim_id,        :null => false
      t.integer :aim_total,       :limit => 9
      t.integer :aim_value1,      :limit => 9
      t.integer :aim_value2,      :limit => 9
      t.integer :aim_value3,      :limit => 9
      t.integer :aim_value4,      :limit => 9
      t.integer :aim_value5,      :limit => 9
      t.integer :aim_value6,      :limit => 9
      t.integer :aim_value7,      :limit => 9
      t.integer :aim_value8,      :limit => 9
      t.integer :aim_value9,      :limit => 9
      t.integer :aim_value10,     :limit => 9
      t.integer :aim_value11,     :limit => 9
      t.integer :aim_value12,     :limit => 9
      t.integer :aim_value13,     :limit => 9
      t.integer :aim_value14,     :limit => 9
      t.integer :aim_value15,     :limit => 9
      t.integer :aim_value16,     :limit => 9
      t.integer :aim_value17,     :limit => 9
      t.integer :aim_value18,     :limit => 9
      t.integer :aim_value19,     :limit => 9
      t.integer :aim_value20,     :limit => 9
      t.integer :aim_value21,     :limit => 9
      t.integer :aim_value22,     :limit => 9
      t.integer :aim_value23,     :limit => 9
      t.integer :aim_value24,     :limit => 9
      t.integer :aim_value25,     :limit => 9
      t.integer :aim_value26,     :limit => 9
      t.integer :aim_value27,     :limit => 9
      t.integer :aim_value28,     :limit => 9
      t.integer :aim_value29,     :limit => 9
      t.integer :aim_value30,     :limit => 9
      t.integer :aim_value31,     :limit => 9
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN d_aims.date IS '年月';
             COMMENT ON COLUMN d_aims.m_shop_id IS '店舗id';
             COMMENT ON COLUMN d_aims.m_aim_id IS '目標id';
             COMMENT ON COLUMN d_aims.aim_total IS '合計';
             COMMENT ON COLUMN d_aims.aim_value1 IS '１日';
             COMMENT ON COLUMN d_aims.aim_value2 IS '２日';
             COMMENT ON COLUMN d_aims.aim_value3 IS '３日';
             COMMENT ON COLUMN d_aims.aim_value4 IS '４日';
             COMMENT ON COLUMN d_aims.aim_value5 IS '５日';
             COMMENT ON COLUMN d_aims.aim_value6 IS '６日';
             COMMENT ON COLUMN d_aims.aim_value7 IS '７日';
             COMMENT ON COLUMN d_aims.aim_value8 IS '８日';
             COMMENT ON COLUMN d_aims.aim_value9 IS '９日';
             COMMENT ON COLUMN d_aims.aim_value10 IS '１０日';
             COMMENT ON COLUMN d_aims.aim_value11 IS '１１日';
             COMMENT ON COLUMN d_aims.aim_value12 IS '１２日';
             COMMENT ON COLUMN d_aims.aim_value13 IS '１３日';
             COMMENT ON COLUMN d_aims.aim_value14 IS '１４日';
             COMMENT ON COLUMN d_aims.aim_value15 IS '１５日';
             COMMENT ON COLUMN d_aims.aim_value16 IS '１６日';
             COMMENT ON COLUMN d_aims.aim_value17 IS '１７日';
             COMMENT ON COLUMN d_aims.aim_value18 IS '１８日';
             COMMENT ON COLUMN d_aims.aim_value19 IS '１９日';
             COMMENT ON COLUMN d_aims.aim_value20 IS '２０日';
             COMMENT ON COLUMN d_aims.aim_value21 IS '２１日';
             COMMENT ON COLUMN d_aims.aim_value22 IS '２２日';
             COMMENT ON COLUMN d_aims.aim_value23 IS '２３日';
             COMMENT ON COLUMN d_aims.aim_value24 IS '２４日';
             COMMENT ON COLUMN d_aims.aim_value25 IS '２５日';
             COMMENT ON COLUMN d_aims.aim_value26 IS '２６日';
             COMMENT ON COLUMN d_aims.aim_value27 IS '２７日';
             COMMENT ON COLUMN d_aims.aim_value28 IS '２８日';
             COMMENT ON COLUMN d_aims.aim_value29 IS '２９日';
             COMMENT ON COLUMN d_aims.aim_value30 IS '３０日';
             COMMENT ON COLUMN d_aims.aim_value31 IS '３１日';
             COMMENT ON COLUMN d_aims.created_user_id IS '作成者id';
             COMMENT ON COLUMN d_aims.updated_user_id IS '更新者id';
    "
    
  end
end
