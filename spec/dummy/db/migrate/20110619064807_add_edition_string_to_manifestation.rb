class AddEditionStringToManifestation < ActiveRecord::Migration
  def self.up
    add_column :manifestations, :edition_string, :string
  end

  def self.down
    remove_column :manifestations, :edition_string
  end
end
