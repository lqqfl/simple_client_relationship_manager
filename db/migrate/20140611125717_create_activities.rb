class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.datetime :time
      t.text :note

      t.timestamps
    end
  end
end
