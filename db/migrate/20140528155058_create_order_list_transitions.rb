class CreateOrderListTransitions < ActiveRecord::Migration[5.2]
  def change
    create_table :order_list_transitions do |t|
      t.string :to_state
      t.jsonb :metadata, default: {}
      t.integer :sort_key
      t.references :order_list
      t.timestamps
    end

    add_index :order_list_transitions, [:sort_key, :order_list_id], unique: true
  end
end
