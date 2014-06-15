class AddEndTimeToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :end_time, :date
    change_column :contracts, :time, :date
    rename_column :contracts, :time, :start_time
  end
end
