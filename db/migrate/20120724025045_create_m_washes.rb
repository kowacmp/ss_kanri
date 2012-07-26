class CreateMWashes < ActiveRecord::Migration
  def change
    create_table :m_washes do |t|
      t.integer :wash_cd
      t.string :wash_name
      t.string :wash_ryaku
      t.integer :wash_group
      t.integer :max_num
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
