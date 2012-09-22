class ChangeColumnMWashes < ActiveRecord::Migration
  def up
    change_column :m_washes, :wash_group,:smallint, :null => true
  end

  def down
  end
end
