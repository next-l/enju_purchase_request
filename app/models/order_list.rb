class OrderList < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordModel
  attr_accessible :user_id, :bookstore_id, :title, :note, :ordered_at,
    :edit_mode
  scope :not_ordered, -> {in_state(:requested)}

  has_many :orders, :dependent => :destroy
  has_many :purchase_requests, :through => :orders
  belongs_to :user, :validate => true
  belongs_to :bookstore, :validate => true
  has_many :subscriptions

  before_create do
    transition_to(:requested)
  end

  validates_presence_of :title, :user, :bookstore
  validates_associated :user, :bookstore

  attr_accessor :edit_mode

  paginates_per 10

  def state_machine
    OrderListStateMachine.new(self, transition_class: OrderListTransition)
  end

  has_many :order_list_transitions

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
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
