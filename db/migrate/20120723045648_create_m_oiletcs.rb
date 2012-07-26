class CreateMOiletcs < ActiveRecord::Migration
  def change
    create_table :m_oiletcs do |t|
      t.integer :oiletc_cd
      t.string :oiletc_name
      t.string :oiletc_ryaku
      t.string :oiletc_tani
      t.integer :oiletc_group
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
