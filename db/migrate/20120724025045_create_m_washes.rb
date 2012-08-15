class CreateMWashes < ActiveRecord::Migration
  def change
    create_table :m_washes do |t|
      t.integer :wash_cd,:default => 0
      t.string :wash_name
      t.string :wash_ryaku
      t.integer :wash_group,:default => 0
      t.integer :max_num,:default => 0
      t.integer :deleted_flg,:default => 0
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
