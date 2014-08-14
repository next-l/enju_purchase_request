class OrderListsController < ApplicationController
  load_and_authorize_resource
  before_filter :prepare_options, only: [:new, :edit]
  before_filter :get_bookstore, only: :index

  # GET /order_lists
  # GET /order_lists.json
  def index
    if @bookstore
      @order_lists = @bookstore.order_lists.page(params[:page])
    else
      @order_lists = OrderList.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_lists }
      format.rss  { render layout: false }
      format.atom
    end
  end

  # GET /order_lists/1
  # GET /order_lists/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_list }
    end
  end

  # GET /order_lists/new
  # GET /order_lists/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_list }
    end
  end

  # GET /order_lists/1/edit
  def edit
    if params[:mode] == 'order'
      @order_list.edit_mode = 'order'
    end
  end

  # POST /order_lists
  # POST /order_lists.json
  def create
    @order_list = OrderList.new(params[:order_list])
    @order_list.user = current_user

    respond_to do |format|
      if @order_list.save
        format.html { redirect_to @order_list, notice: t('controller.successfully_created', model: t('activerecord.models.order_list')) }
        format.json { render json: @order_list, status: :created, location: @order_list }
      else
        prepare_options
        format.html { render action: "new" }
        format.json { render json: @order_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_lists/1
  # PUT /order_lists/1.json
  def update

    respond_to do |format|
      if @order_list.update_attributes(params[:order_list])
        if @order_list.edit_mode == 'order'
          @order_list.transition_to(:ordered)
          @order_list.save(validate: false)
          format.html { redirect_to purchase_requests_url(order_list_id: @order_list.id), notice: t('controller.successfully_updated', model: t('activerecord.models.order_list')) }
        else
          format.html { redirect_to @order_list , notice: t('controller.successfully_updated', model: t('activerecord.models.order_list')) }
        end
        format.json { head :no_content }
      else
        prepare_options
        format.html { render action: "edit" }
        format.json { render json: @order_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_lists/1
  # DELETE /order_lists/1.json
  def destroy
    @order_list.destroy

    respond_to do |format|
      format.html { redirect_to order_lists_url }
      format.json { head :no_content }
    end
  end

  private
  def prepare_options
    @bookstores = Bookstore.all
  end
end
