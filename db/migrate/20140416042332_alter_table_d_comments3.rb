class AlterTableDComments3 < ActiveRecord::Migration
  def up
    change_column :d_comments, :contents,:string, :limit => 150, :null => true
  end

  def down
  end
end
