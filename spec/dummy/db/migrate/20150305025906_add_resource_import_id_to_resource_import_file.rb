class AddResourceImportIdToResourceImportFile < ActiveRecord::Migration[5.0]
  def change
    add_column :resource_import_files, :resource_import_id, :string, index: true
  end
end
