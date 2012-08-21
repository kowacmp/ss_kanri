# encoding: utf-8
class CreateDSales < ActiveRecord::Migration
  def change
    create_table :d_sales do |t|
      t.string :sale_date ,:limit => 8, :null => false
      t.integer :m_shop_id, :null => false
      t.integer :kakutei_flg, :limit => 1, :null => false
      t.integer :sale_money1
      t.integer :sale_money2
      t.integer :sale_money3
      t.integer :sale_purika
      t.integer :sale_today_out
      t.integer :sale_change1
      t.integer :sale_change2
      t.integer :sale_change3
      t.integer :sale_ass
      t.integer :recive_money
      t.integer :pay_money
      t.integer :sale_cashbox
      t.integer :sale_changebox
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps
    end
    
    execute "
COMMENT ON COLUMN d_sales.id IS 'ID';
COMMENT ON COLUMN d_sales.sale_date IS '売上日';
COMMENT ON COLUMN d_sales.m_shop_id IS '店舗id';
COMMENT ON COLUMN d_sales.kakutei_flg IS '確定フラグ';
COMMENT ON COLUMN d_sales.sale_money1 IS '売上金額1';
COMMENT ON COLUMN d_sales.sale_money2 IS '売上金額2';
COMMENT ON COLUMN d_sales.sale_money3 IS '売上金額3';
COMMENT ON COLUMN d_sales.sale_purika IS 'プリカ';
COMMENT ON COLUMN d_sales.sale_today_out IS '当日出';
COMMENT ON COLUMN d_sales.sale_change1 IS '釣銭機1';
COMMENT ON COLUMN d_sales.sale_change2 IS '釣銭機2';
COMMENT ON COLUMN d_sales.sale_change3 IS '釣銭機3';
COMMENT ON COLUMN d_sales.sale_ass IS 'ass';
COMMENT ON COLUMN d_sales.recive_money IS '入金';
COMMENT ON COLUMN d_sales.pay_money IS '出金';
COMMENT ON COLUMN d_sales.sale_cashbox IS '固定金庫';
COMMENT ON COLUMN d_sales.sale_changebox IS '釣銭機固定金庫';
COMMENT ON COLUMN d_sales.created_user_id IS '作成者id';
COMMENT ON COLUMN d_sales.created_at IS '作成日時';
COMMENT ON COLUMN d_sales.updated_user_id IS '更新者id';
COMMENT ON COLUMN d_sales.updated_at IS '更新日時';
    "          

  end
end
