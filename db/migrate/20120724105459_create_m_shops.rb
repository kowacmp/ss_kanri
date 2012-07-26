class CreateMShops < ActiveRecord::Migration
  def change
    create_table :m_shops do |t|
      t.integer :shop_cd
      t.string :shop_name
      t.string :shop_kana
      t.string :shop_ryaku
      t.string :shop_zip_cd
      t.string :shop_adress
      t.string :shop_tel
      t.string :shop_fax
      t.string :shop_mail_adress
      t.integer :shop_kbn
      t.integer :m_shop_group_id
      t.integer :m_oil_id1
      t.integer :tank1_all
      t.integer :m_oil_id2
      t.integer :tank2_all
      t.integer :m_oil_id3
      t.integer :tank3_all
      t.integer :m_oil_id4
      t.integer :tank4_all
      t.integer :etc_oil_flg
      t.integer :etc_flg
      t.integer :wash_flg
      t.integer :wash_sale_flg
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
