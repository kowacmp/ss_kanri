class CreateMKeepMonths < ActiveRecord::Migration
  def change
    create_table :m_keep_months do |t|
      t.column :display_order,  :smallint,     :null => false, :default => 0
      t.string :display_name,   :limit => 100
      t.column :keep_month,  :smallint,     :null => false, :default => 0
      t.timestamps
    end
  end
end
