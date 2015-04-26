class OrderListTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :order_list, inverse_of: :order_list_transitions
end

# == Schema Information
#
# Table name: order_list_transitions
#
#  id            :integer          not null, primary key
#  to_state      :string
#  metadata      :text             default({})
#  sort_key      :integer
#  order_list_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#
