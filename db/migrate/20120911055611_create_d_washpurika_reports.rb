class CreateDWashpurikaReports < ActiveRecord::Migration
  def change
    create_table :d_washpurika_reports do |t|
      t.string   :date,            :null => false , :limit => 6 
      t.integer  :m_shop_id,       :null => false
      t.integer  :total_rank,      :null => false
      t.integer  :league,          :null => false
      t.integer  :before_rank,     :null => false
      t.integer  :total_point,     :default => 0                
      t.integer  :result1,         :default => 0       
      t.integer  :result2,         :default => 0  
      t.integer  :result3,         :default => 0     
      t.integer  :result4,         :default => 0
      t.integer  :result5,         :default => 0
      t.integer  :result6,         :default => 0
      t.integer  :result7,         :default => 0
      t.integer  :result8,         :default => 0
      t.integer  :result9,         :default => 0
      t.integer  :result10,        :default => 0
      t.integer  :result11,        :default => 0
      t.integer  :result12,        :default => 0
      t.integer  :result13,        :default => 0
      t.integer  :result14,        :default => 0
      t.integer  :result15,        :default => 0
      t.integer  :result16,        :default => 0
      t.integer  :result17,        :default => 0
      t.integer  :result18,        :default => 0
      t.integer  :result19,        :default => 0
      t.integer  :result20,        :default => 0
      t.integer  :result21,        :default => 0
      t.integer  :result22,        :default => 0
      t.integer  :result23,        :default => 0
      t.integer  :result24,        :default => 0
      t.integer  :result25,        :default => 0
      t.integer  :result26,        :default => 0
      t.integer  :result27,        :default => 0
      t.integer  :result28,        :default => 0
      t.integer  :result29,        :default => 0
      t.integer  :result30,        :default => 0
      t.integer  :result31,        :default => 0
      t.integer  :pace,            :default => 0
      t.integer  :wash_sale,       :default => 0
      t.integer  :same_day_pace,   :default => 0
      t.integer  :same_day_result, :default => 0
      t.integer  :created_user_id
      t.integer  :updated_user_id
      t.timestamps
    end
  end
end
