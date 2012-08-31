class ChangeColumnDResultReport < ActiveRecord::Migration
  def up
    change_column :d_result_reports, :koua, :decimal, :precision => 11, :scale => 2
    change_column :d_result_reports, :atf, :decimal, :precision => 11, :scale => 2
    change_column :d_result_reports, :mobil1, :decimal, :precision => 11, :scale => 2
  end

  def down
  end
end
