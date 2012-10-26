# -*- coding:utf-8 -*-
class ChangeCommentDWashpurikaReports < ActiveRecord::Migration
  def up
    
    execute "COMMENT ON COLUMN d_washpurika_reports.before_league      IS '今月リーグ'; "
    execute "COMMENT ON COLUMN d_washpurika_reports.before_rank        IS '今月ランク'; "
    execute "COMMENT ON COLUMN d_washpurika_reports.before_total_point IS '今月獲得pt'; "
    
    execute "COMMENT ON COLUMN d_washpurika_reports.league      IS '次月繰越リーグ(今月末迄の売上金額ソート及びリーグ入れ替え済)'; "
    execute "COMMENT ON COLUMN d_washpurika_reports.rank        IS '次月繰越ランク(今月末迄の売上金額ソート及びリーグ入れ替え済)'; "
    execute "COMMENT ON COLUMN d_washpurika_reports.total_point IS '次月繰越獲得pt(今月末迄の売上金額反映後でのポイント加算済)';   "
    
  end

  def down
    
  end
end
