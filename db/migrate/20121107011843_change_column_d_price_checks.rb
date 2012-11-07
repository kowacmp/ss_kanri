class ChangeColumnDPriceChecks < ActiveRecord::Migration
  def up
    change_column :d_price_checks, :minus_gak1, :decimal, :precision => 3, :scale => 1
    change_column :d_price_checks, :minus_gak2, :decimal, :precision => 3, :scale => 1
    change_column :d_price_checks, :minus_gak3, :decimal, :precision => 3, :scale => 1
  end

  def down
    change_column :d_price_checks, :minus_gak1, :integer
    change_column :d_price_checks, :minus_gak2, :integer
    change_column :d_price_checks, :minus_gak3, :integer
  end
end
