class CreateAuthorityMenus < ActiveRecord::Migration
  def change
    create_table :authority_menus do |t|
      t.column   :m_authority_id,  :smallint,  :null => false
      t.column   :menu_id,         :smallint,  :null => false
      t.timestamps      
    end   
  end
end
