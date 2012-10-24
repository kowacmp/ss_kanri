# -*- coding:utf-8 -*-
class AlterTableDComments < ActiveRecord::Migration
  def up
    add_column :d_comments, :m_shop_id, :integer
    add_column :d_comments, :nengetu, :string, :limit=>8
    add_column :d_comments, :renban, :integer, :limit=>1
    
    execute "COMMENT ON COLUMN d_comments.m_shop_id IS '人件費処理の場合設定';"
    execute "COMMENT ON COLUMN d_comments.nengetu IS '人件費処理の場合設定';"
    execute "COMMENT ON COLUMN d_comments.renban IS '人件費処理の場合設定　10日：１、20日：２、月末：３';"
  end

  def down
  end
end
