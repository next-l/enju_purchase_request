module EnjuPurchaseRequest
  module Controller
    private

    def set_order_list
      if params[:order_list_id]
        @order_list = OrderList.find(params[:order_list_id])
        authorize @order_list, :show?
      end
    end

    def set_purchase_request
      if params[:purchase_request_id]
        @purchase_request = PurchaseRequest.find(params[:purchase_request_id])
        authorize @purchase_request,  :show?
      end
    end
  end
end
