require 'rails_helper'

describe Order do
  # pending "add some examples to (or delete) #{__FILE__}"
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
