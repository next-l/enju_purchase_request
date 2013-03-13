module EnjuPurchaseRequest
  module PurchaseRequestUser
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_purchase_request_user_model
        has_many :purchase_requests
        has_many :order_lists
      end
    end
  end
end
