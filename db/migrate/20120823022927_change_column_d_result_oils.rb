class ChangeColumnDResultOils < ActiveRecord::Migration
  def up
    change_column :d_result_oils, :pos1_data, :decimal, :precision => 9, :scale => 2
    change_column :d_result_oils, :pos2_data, :decimal, :precision => 9, :scale => 2
    change_column :d_result_oils, :pos3_data, :decimal, :precision => 9, :scale => 2    
  end

  def down
  end
end
