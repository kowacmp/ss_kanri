class CreateMAuthorities < ActiveRecord::Migration
  def up
    create_table :m_authorities do |t|
      t.column   :authority_cd,   :smallint,     :null => false, :default => 0
      t.string   :authority_name, :limit => 100, :null => false
      t.column   :deleted_flg,    :smallint,     :null => false, :default => 0
      t.datetime :deleted_at
      t.timestamps      
    end
  end

  def down
    drop_table :m_authorities
  end
end
