class OrderList < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordModel
  scope :not_ordered, -> {in_state(:pending)}

  has_many :orders, :dependent => :destroy
  has_many :purchase_requests, :through => :orders
  belongs_to :user, :validate => true
  belongs_to :bookstore, :validate => true
  has_many :subscriptions

  validates_presence_of :title, :user, :bookstore
  validates_associated :user, :bookstore

  paginates_per 10

  has_many :order_list_transitions

  def state_machine
    OrderListStateMachine.new(self, transition_class: OrderListTransition)
  end

  delegate :can_transition_to?, :transition_to!, :transition_to, :current_state,
    to: :state_machine

  def total_price
    self.purchase_requests.sum(:price)
  end

  def order
    self.ordered_at = Time.zone.now
  end

  def ordered?
    true if self.ordered_at.present?
  end

  private
  def self.transition_class
    OrderListTransition
  end
end

# == Schema Information
#
# Table name: order_lists
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  bookstore_id :integer          not null
#  title        :text             not null
#  note         :text
#  ordered_at   :datetime
#  deleted_at   :datetime
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

