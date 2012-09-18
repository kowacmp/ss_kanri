# -*- coding:utf-8 -*-
class CreateMGetPoints < ActiveRecord::Migration
  def change
    create_table :m_get_points do |t|
      t.column  :rank,        :smallint, :default => 0
      t.column  :league_rank, :smallint, :default => 0
      t.integer :pt, :default => 0

      t.timestamps
    end
    
    execute "COMMENT ON COLUMN m_get_points.rank IS '順位';
             COMMENT ON COLUMN m_get_points.league_rank IS 'リーグ順位';
             COMMENT ON COLUMN m_get_points.pt IS '獲得ポイント';
    "
    
  end
end
