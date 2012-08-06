class CreateUserdata < ActiveRecord::Migration
  def change
    create_table :userdata do |t|
      t.string :id
      t.string :pseudo
      t.string :email
      t.string :firstname

      t.timestamps
    end
  end
end
