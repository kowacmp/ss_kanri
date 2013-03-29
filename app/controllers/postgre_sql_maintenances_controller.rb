class PostgreSqlMaintenancesController < ApplicationController

  skip_before_filter :permission_check

  include PostgreSqlMaintenancesHelper

  def index
    # push test
  end

  def sequence
    
    # 管理者パスワードのチェック
    if chk_pass(params["seq_password"]).to_s != "true" then
      redirect_to :action => "index"
    end
    
    @sequences = get_all_sequences()
    
  end

  def seq_update
    
    i = 1
    until params["update_seq#{ i }"].nil? do
      # 更新パラメータ取得
      update_seq = params["update_seq#{ i }"]
      
      # シーケンスを更新する
      if update_seq["update_flg"].to_s == "true" then
        sql = "SELECT SETVAL('#{ update_seq["seq_name"] }', #{ update_seq["seq_id"] })"
        p sql
        execute_sql(sql)
      end
      
      i += 1
    end
    
    redirect_to :action => "sequence"

  end
  
private

  # 管理者パスワードチェック
  def chk_pass(pass) 
    return (pass.to_s == "kowacomputer")
  end
  
end
