class AlterTableDComments2 < ActiveRecord::Migration
  def up
    change_column :d_comments, :contents,:string, :limit => 100, :null => true
  end

  def down
  end
end
