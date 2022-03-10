class Order < ActiveRecord::Base
  belongs_to :order_list
  belongs_to :purchase_request

  validates :purchase_request_id, uniqueness: { scope: :order_list_id }

  after_save :reindex
  after_destroy :reindex

  acts_as_list scope: :order_list

  paginates_per 10

  def reindex
    purchase_request.try(:index)
  end
end

# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  order_list_id       :integer          not null
#  purchase_request_id :integer          not null
#  position            :integer
#  state               :string
#  created_at          :datetime
#  updated_at          :datetime
#
