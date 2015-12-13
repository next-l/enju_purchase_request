class ApplicationController < ActionController::Base
  protect_from_forgery
  include EnjuLeaf::Controller
  include EnjuBiblio::Controller
  include EnjuLibrary::Controller
  include EnjuPurchaseRequest::Controller
  after_action :verify_authorized

  include Pundit
end
