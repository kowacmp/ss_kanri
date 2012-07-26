class CreateMTanks < ActiveRecord::Migration
  def change
    create_table :m_tanks do |t|
      t.integer :m_shop_id
      t.integer :m_oil_id
      t.integer :tank_all
      t.integer :measure1
      t.integer :measure2
      t.integer :measure3
      t.integer :measure4
      t.integer :measure5
      t.integer :measure6
      t.integer :measure7
      t.integer :measure8
      t.integer :measure9
      t.integer :measure10
      t.integer :measure11
      t.integer :measure12
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
