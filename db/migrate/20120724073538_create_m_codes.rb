class CreateMCodes < ActiveRecord::Migration
  def change
    create_table :m_codes do |t|
      t.string :kbn
      t.string :code
      t.string :code_name
      t.string :code_name1

      t.timestamps
    end
  end
end
