class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :company, index: true, default: 0
      t.references :contact, index: true, default: 0
      t.references :user, index: true, default: 0
      t.references :opportunity, index: true, default: 0
      t.references :activity, index: true, default: 0
      t.references :cotract, index: true, default: 0

      t.timestamps
    end
  end
end
