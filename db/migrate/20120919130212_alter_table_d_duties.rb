class AlterTableDDuties < ActiveRecord::Migration
  def up
    change_column :d_duties, :day_work_time, :decimal, :precision=>3, :scale=>1, :default => 0
    change_column :d_duties, :night_work_time, :decimal, :precision=>3, :scale=>1, :default => 0
    change_column :d_duties, :all_work_time, :decimal, :precision=>3, :scale=>1, :default => 0
    change_column :d_duties, :day_work_money, :integer, :default => 0    
  end

  def down
  end
end
