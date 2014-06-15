class AddRealAmountToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :real_amount, :decimal, precision: 10, scale: 2, default: 0
    rename_column :contracts, :amount, :exp_amount
  end
end
