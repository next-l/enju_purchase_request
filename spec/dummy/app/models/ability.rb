class Ability
  include CanCan::Ability

  def initialize(user)
    case user.try(:role).try(:name)
    when 'Administrator'
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
