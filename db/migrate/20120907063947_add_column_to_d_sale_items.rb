class AddColumnToDSaleItems < ActiveRecord::Migration
  def change
    execute "alter table d_sale_items alter column item_money set default 0"
    
    execute "update d_sale_items set item_money = 0 where item_money is null"
  end
end
