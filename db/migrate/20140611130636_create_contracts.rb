class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.decimal :amount, precision: 10, scale: 2, default: 0
      t.text :note
      t.datetime :time

      t.timestamps
    end
  end
end
