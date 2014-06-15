class RenameColumnRelationshipsCotract < ActiveRecord::Migration
  def change
    rename_column :relationships, :cotract_id, :contract_id
  end
end
