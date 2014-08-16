class OrderListTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :order_list, inverse_of: :order_list_transitions
  attr_accessible :to_state, :sort_key, :metadata
end

# == Schema Information
#
# Table name: order_list_transitions
#
#  id            :integer          not null, primary key
#  to_state      :string(255)
#  metadata      :text             default("{}")
#  sort_key      :integer
#  order_list_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#