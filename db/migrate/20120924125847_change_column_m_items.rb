class ChangeColumnMItems < ActiveRecord::Migration
  def up
    change_column :m_items, :m_item_account_id,:integer, :null => true
  end

  def down
  end
end
