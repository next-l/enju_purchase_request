Rails.application.routes.draw do
  resources :purchase_requests do
    resource :order
  end
  resources :users do
    resources :purchase_requests
  end
  resources :order_lists do
    resources :purchase_requests
  end
  resources :order_lists do
    resource :order
  end
  resources :orders
  resources :bookstores do
    resources :order_lists
  end
end
