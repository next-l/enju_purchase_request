class AddErrorMessageToAgentImportFile < ActiveRecord::Migration[4.2]
  def change
    add_column :agent_import_files, :error_message, :text
  end
end
