class ChangeColumnDResultOiletcs < ActiveRecord::Migration
  def up
    change_column :d_result_oiletcs, :pos1_data, :decimal, :precision => 11, :scale => 2
    change_column :d_result_oiletcs, :pos2_data, :decimal, :precision => 11, :scale => 2
    change_column :d_result_oiletcs, :pos3_data, :decimal, :precision => 11, :scale => 2    
  end

  def down
  end
end
