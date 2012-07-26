class CreateAuthorityMenus < ActiveRecord::Migration
  def up
    create_table :authority_menus do |t|
      t.column   :m_authority_id,  :smallint,  :null => false
      t.column   :menu_id,         :smallint,  :null => false
      t.timestamps      
    end   
  end

  def down
     drop_table :authority_menus  
  end
end
