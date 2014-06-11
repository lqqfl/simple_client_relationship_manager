class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :name
      t.decimal :amount
      t.text :note
      t.datetime :time

      t.timestamps
    end
  end
end
