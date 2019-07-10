class AddMostRecentToOrderListTransitions < ActiveRecord::Migration[4.2]
  def up
    add_column :order_list_transitions, :most_recent, :boolean, null: true
  end

  def down
    remove_column :order_list_transitions, :most_recent
  end
end
