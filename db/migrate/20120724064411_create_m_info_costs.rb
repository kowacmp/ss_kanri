class CreateMInfoCosts < ActiveRecord::Migration
  def change
    create_table :m_info_costs do |t|
      t.integer :users_id
      t.integer :base_pay
      t.integer :night_pay
      t.integer :welfare_pay
      t.integer :etc_pay1
      t.integer :etc_pay2
      t.integer :etc_pay3
      t.integer :etc_pay4
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
