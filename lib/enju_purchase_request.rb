require "enju_purchase_request/engine"
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
      if params[:order_list_id]
        @order_list = OrderList.find(params[:order_list_id])
        authorize @order_list, :show?
      end
    end

    def get_purchase_request
      if params[:purchase_request_id]
        @purchase_request = PurchaseRequest.find(params[:purchase_request_id])
        authorize @purchase_request,  :show?
      end
    end
  end
end

ActionController::Base.send(:include, EnjuPurchaseRequest)
