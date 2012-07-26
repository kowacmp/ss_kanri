class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.column   :parent_menu_id, :smallint,     :null => false
      t.column   :display_order,  :smallint,     :null => false, :default => 0
      t.string   :display_name,   :limit => 100
      t.string   :uri,            :limit => 100
      t.timestamps      
    end    
  end
end
