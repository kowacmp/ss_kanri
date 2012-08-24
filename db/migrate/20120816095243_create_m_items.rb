# encoding: utf-8
class CreateMItems < ActiveRecord::Migration
  def change
    create_table :m_items do |t|
      t.integer :item_class, :limit => 1, :null => false
      t.string :item_name, :limit => 30
      t.string :item_ryaku, :limit => 10
      t.integer :m_item_account, :limit => 4, :null => false

      t.timestamps
    end
    execute "
COMMENT ON COLUMN m_items.id IS 'ID';
COMMENT ON COLUMN m_items.item_class IS '内訳種別';
COMMENT ON COLUMN m_items.item_name IS '内訳称';
COMMENT ON COLUMN m_items.item_ryaku IS '内訳略称';
COMMENT ON COLUMN m_items.m_item_account IS '内訳科目';
COMMENT ON COLUMN m_items.created_at IS '作成日時';
COMMENT ON COLUMN m_items.updated_at IS '更新日時';
    "          
 
  end
end
