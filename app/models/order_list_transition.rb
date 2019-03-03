class OrderListTransition < ActiveRecord::Base

  
  belongs_to :order_list, inverse_of: :order_list_transitions
end

# == Schema Information
#
# Table name: order_list_transitions
#
#  id            :bigint(8)        not null, primary key
#  to_state      :string
#  metadata      :jsonb
#  sort_key      :integer
#  order_list_id :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  most_recent   :boolean
#
