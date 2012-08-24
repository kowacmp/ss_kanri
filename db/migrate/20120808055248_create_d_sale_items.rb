# encoding: utf-8
class CreateDSaleItems < ActiveRecord::Migration
  def change
    create_table :d_sale_items do |t|
      t.integer :d_sale_id, :null => false
      t.integer :item_class, :limit => 1, :null => false
      t.integer :m_item_id
      t.string :item_name, :limit => 30
      t.integer :item_money
      t.integer :m_shop_id
      t.integer :created_user_id
      t.integer :updated_user_id

      t.timestamps
    end
    
    execute "
COMMENT ON COLUMN d_sale_items.id IS 'ID';
COMMENT ON COLUMN d_sale_items.d_sale_id IS '売上データid';
COMMENT ON COLUMN d_sale_items.item_class IS '内訳種別';
COMMENT ON COLUMN d_sale_items.m_item_id IS '内訳id';
COMMENT ON COLUMN d_sale_items.item_name IS '内訳';
COMMENT ON COLUMN d_sale_items.item_money IS '金額';
COMMENT ON COLUMN d_sale_items.m_shop_id IS '店舗id';
COMMENT ON COLUMN d_sale_items.created_user_id IS '作成者id';
COMMENT ON COLUMN d_sale_items.created_at IS '作成日時';
COMMENT ON COLUMN d_sale_items.updated_user_id IS '更新者id';
COMMENT ON COLUMN d_sale_items.updated_at IS '更新日時';
    "          

  end
end
