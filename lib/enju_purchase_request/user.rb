class User < ActiveRecord::Base
  has_many :purchase_requests
  has_many :order_lists
end
