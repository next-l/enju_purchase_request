class PurchaseRequestsController < ApplicationController
  load_and_authorize_resource except: :index
  authorize_resource only: :index
  before_filter :get_user
  before_filter :get_order_list
  before_filter :store_page, only: :index
  after_filter :solr_commit, only: [:create, :update, :destroy]
  after_filter :convert_charset, only: :index

  # GET /purchase_requests
  # GET /purchase_requests.json
  def index
    @count = {}
    if params[:format] == 'txt'
      per_page = 65534
    else
      per_page = PurchaseRequest.default_per_page
    end

    query = params[:query].to_s.strip
    @query = query.dup
    mode = params[:mode]

    user = @user
    unless current_user.has_role?('Librarian')
      if user and user != current_user
        access_denied; return
      end
      if current_user == @user
        redirect_to purchase_requests_url(format: params[:format])
        return
      end
    end

    order_list = @order_list
    search = Sunspot.new_search(PurchaseRequest)
    search.build do
      fulltext query if query.present?
      if user
        with(:user_id).equal_to user.id
      else
        with(:user_id).equal_to current_user.id
      end
      with(:order_list_id).equal_to order_list.id if order_list
      case mode
      when 'not_ordered'
        with(:ordered).equal_to false
      when 'ordered'
        with(:ordered).equal_to true
      end
      order_by(:created_at, :desc)
    end

    page = params[:page] || "1"
    flash[:page] = page if page.to_i >= 1
    search.query.paginate(page.to_i, per_page)
    @purchase_requests = search.execute!.results

    @count[:query_result] = @purchase_requests.size

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchase_requests }
      format.rss  { render layout: false }
      format.atom
      format.txt
    end
  end

  # GET /purchase_requests/1
  # GET /purchase_requests/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase_request }
    end
  end

  # GET /purchase_requests/new
  # GET /purchase_requests/new.json
  def new
    @purchase_request = current_user.purchase_requests.new(purchase_request_params)
    if defined?(EnjuBookmark)
      @purchase_request.title = Bookmark.get_title_from_url(@purchase_request.url) unless @purchase_request.title?
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase_request }
    end
  end

  # GET /purchase_requests/1/edit
  def edit
  end

  # POST /purchase_requests
  # POST /purchase_requests.json
  def create
    @purchase_request = current_user.purchase_requests.new(purchase_request_params)

    respond_to do |format|
      if @purchase_request.save
        @order_list.purchase_requests << @purchase_request if @order_list
        flash[:notice] = t('controller.successfully_created', model: t('activerecord.models.purchase_request'))
        format.html { redirect_to(@purchase_request) }
        format.json { render json: @purchase_request, status: :created, location: @purchase_request }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchase_requests/1
  # PUT /purchase_requests/1.json
  def update
    respond_to do |format|
      if @purchase_request.update_attributes(purchase_request_params)
        @order_list.purchase_requests << @purchase_request if @order_list
        flash[:notice] = t('controller.successfully_updated', model: t('activerecord.models.purchase_request'))
        format.html { redirect_to(@purchase_request) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_requests/1
  # DELETE /purchase_requests/1.json
  def destroy
    @purchase_request.destroy

    respond_to do |format|
      format.html { redirect_to purchase_requests_url }
      format.json { head :no_content }
    end
  end

  private
  def purchase_request_params
    params.fetch(:purchase_request, {}).permit(
      :title, :author, :publisher, :isbn, :price, :url, :note, :pub_date
    )
  end
end
