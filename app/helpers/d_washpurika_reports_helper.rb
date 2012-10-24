# -*- coding:utf-8 -*-
module DWashpurikaReportsHelper
  
  # リーグ件数カウント
  def get_league_count(d_washpurika_reports, z_league)
  
    cnt = 0
    
    for rec in d_washpurika_reports
      if rec["before_league"] == z_league then
        cnt += 1
      end
    end

    return cnt
  
  end
  
  # リーグ名取得 (1:A, 2:B, 3:C, ‥ )
  def get_league_chr(league_num)
    
    a_ascii = "A".bytes.to_a[0]
    return (a_ascii + league_num - 1).chr
    
  end
  
end