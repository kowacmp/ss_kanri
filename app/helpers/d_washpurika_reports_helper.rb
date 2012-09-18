# -*- coding:utf-8 -*-
module DWashpurikaReportsHelper
  
  # リーグ件数カウント
  def get_league_count(d_washpurika_reports, z_league)
  
    cnt = 0
    
    for rec in d_washpurika_reports
      if rec["z_league"] == z_league then
        cnt += 1
      end
    end

    return cnt
  
  end
  
end