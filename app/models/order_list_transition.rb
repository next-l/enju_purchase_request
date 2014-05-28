class OrderListTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :order_list, inverse_of: :order_list_transitions
end
