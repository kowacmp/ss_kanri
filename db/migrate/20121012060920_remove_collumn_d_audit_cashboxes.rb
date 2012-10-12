# -*- coding:utf-8 -*-
class RemoveCollumnDAuditCashboxes < ActiveRecord::Migration
  def up
    # 硬貨の枚は削除
    remove_column :d_audit_cashboxes, :cashbox1_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox1_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox1_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox1_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox1_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox1_1coin_mai
    
    remove_column :d_audit_cashboxes, :cashbox2_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox2_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox2_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox2_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox2_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox2_1coin_mai
    
    remove_column :d_audit_cashboxes, :cashbox3_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox3_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox3_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox3_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox3_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox3_1coin_mai
    
    remove_column :d_audit_cashboxes, :cashbox4_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox4_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox4_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox4_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox4_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox4_1coin_mai
    
    remove_column :d_audit_cashboxes, :cashbox5_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox5_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox5_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox5_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox5_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox5_1coin_mai
    
    remove_column :d_audit_cashboxes, :cashbox6_500coin_mai
    remove_column :d_audit_cashboxes, :cashbox6_100coin_mai
    remove_column :d_audit_cashboxes, :cashbox6_50coin_mai
    remove_column :d_audit_cashboxes, :cashbox6_10coin_mai
    remove_column :d_audit_cashboxes, :cashbox6_5coin_mai
    remove_column :d_audit_cashboxes, :cashbox6_1coin_mai
    
  end

  def down
    # 戻すことは考えない
  end
end
