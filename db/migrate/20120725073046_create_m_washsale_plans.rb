class CreateMWashsalePlans < ActiveRecord::Migration
  def change
    create_table :m_washsale_plans do |t|
      t.integer :m_shop_id
      t.integer :m_wash_id
      t.integer :sunday
      t.integer :monday
      t.integer :tuesday
      t.integer :wednesday
      t.integer :thursday
      t.integer :friday
      t.integer :saturday
      t.integer :created_user_id
      t.integer :updated_user_id
      t.integer :deleted_flg
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
