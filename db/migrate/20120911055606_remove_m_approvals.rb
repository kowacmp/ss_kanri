class RemoveMApprovals < ActiveRecord::Migration
  def up
    remove_column :m_approvals, :approval_name1
    remove_column :m_approvals, :approval_name2
    remove_column :m_approvals, :approval_name3
    remove_column :m_approvals, :approval_name4
    remove_column :m_approvals, :approval_name5
  end

  def down
  end
end
