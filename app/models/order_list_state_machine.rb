class OrderListStateMachine
  include Statesman::Machine
  state :pending, initial: true
  state :requested
  state :ordered

  transition from: :pending, to: :requested
  transition from: :requested, to: :ordered

  before_transition(to: :ordered) do |order_list|
    order_list.order
  end
end
