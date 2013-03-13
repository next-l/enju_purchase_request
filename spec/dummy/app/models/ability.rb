#module EnjuPurchaseRequest
  class Ability
    include CanCan::Ability
  
    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can :destroy, Bookstore do |bookstore|
          bookstore.order_lists.empty? and bookstore.items.empty?
        end
        can :manage, [
          Order,
          OrderList,
          PurchaseRequest
        ]
      when 'Librarian'
        can :manage, [
          Order,
          OrderList,
          PurchaseRequest
        ]
      when 'User'
        can [:index, :create], PurchaseRequest
        can [:show, :update, :destroy], PurchaseRequest do |purchase_request|
          purchase_request.user == user
        end
      end
    end
  end
#end
