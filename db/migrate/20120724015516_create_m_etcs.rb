class CreateMEtcs < ActiveRecord::Migration
  def change
    create_table :m_etcs do |t|
      t.integer :etc_cd
      t.string :etc_name
      t.string :etc_ryaku
      t.string :etc_tani
      t.integer :etc_group
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
