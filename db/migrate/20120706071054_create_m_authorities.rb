class CreateMAuthorities < ActiveRecord::Migration
  def change
    create_table :m_authorities do |t|
      t.column   :authority_cd,   :smallint,     :null => false, :default => 0
      t.string   :authority_name, :limit => 100, :null => false
      t.column   :deleted_flg,    :smallint,     :null => false, :default => 0
      t.datetime :deleted_at
      t.timestamps      
    end
  end
end
