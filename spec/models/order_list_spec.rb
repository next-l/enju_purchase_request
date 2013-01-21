# -*- encoding: utf-8 -*-
require 'spec_helper'

describe OrderList do
  fixtures :all

  it "should calculate total price" do
    order_list = order_lists(:order_list_00001)
    order_list.total_price.should eq 0
    order_list.purchase_requests << purchase_requests(:purchase_request_00006)
    order_list.total_price.should eq purchase_requests(:purchase_request_00006).price
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

