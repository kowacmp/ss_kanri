class CreateMOils < ActiveRecord::Migration
  def change
    create_table :m_oils do |t|
      t.integer :oil_cd
      t.string :oil_name
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
