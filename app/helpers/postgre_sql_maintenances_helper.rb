module PostgreSqlMaintenancesHelper

  # シーケンスの一覧を取得する
  def get_all_sequences
    
    sql = "select relname as sequences_name from pg_statio_all_sequences "
    return get_active_record(sql)
    
  end

  # シーケンス名よりテーブル名を取得する
  def get_table_name(sequences_name)

    table_name = sequences_name[0..(sequences_name.length - 8)]
    return table_name

  end

  # シーケンスの値を取得する
  def get_sequence_value(sequences_name)

    sql = "select last_value from #{sequences_name}"
    return get_active_record(sql)[0]["last_value"]

  end
  
  # テーブルの最大IDを取得する
  def get_max_id(table_name)
  
    sql = "select max(id) as max_id from #{table_name}"
  
    ret = get_active_record(sql)[0]["max_id"]
    if ret.nil? then
      ret = 0
    end
    return ret
  
  end

private 

  # SQL実行(select系)
  def get_active_record(sql)

    return User.find_by_sql(sql)

  end
  
  # SQL実行(update系)
  def execute_sql(sql)

    User.connection.execute(sql)

  end

end
