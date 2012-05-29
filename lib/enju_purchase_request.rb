require "enju_purchase_request/engine"
require "enju_purchase_request/bookstore"
require "enju_purchase_request/url_validator"
require "enju_purchase_request/bookmark_url"

module EnjuPurchaseRequest
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def enju_purchase_request
      include EnjuPurchaseRequest::InstanceMethods
    end
  end

  module InstanceMethods
    private

    def get_order_list
      @order_list = OrderList.find(params[:order_list_id]) if params[:order_list_id]
    end

    def get_purchase_request
      @purchase_request = PurchaseRequest.find(params[:purchase_request_id]) if params[:purchase_request_id]
    end
  end
end

ActionController::Base.send(:include, EnjuPurchaseRequest)
