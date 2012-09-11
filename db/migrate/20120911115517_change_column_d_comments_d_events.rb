#coding: utf-8
class ChangeColumnDCommentsDEvents < ActiveRecord::Migration
  def up
    rename_column :d_comments, :menu_id, :title
    change_column :d_comments, :title, :string ,:limit => 20
    rename_column :d_events, :menu_id, :title
    change_column :d_events, :title, :string ,:limit => 20  
    
    execute "COMMENT ON COLUMN d_comments.title IS 'タイトル'"
    execute "COMMENT ON COLUMN d_events.title IS 'タイトル'"   
  end

  def down
  end
end
