class OrderListsController < ApplicationController
  before_action :set_order_list, only: [:show, :edit, :update, :destroy]
  before_action :get_bookstore
  after_action :verify_authorized

  # GET /order_lists
  # GET /order_lists.json
  def index
    authorize OrderList
    if @bookstore
      @order_lists = @bookstore.order_lists.page(params[:page])
    else
      @order_lists = OrderList.page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @order_lists }
      format.rss  { render :layout => false }
      format.atom
    end
  end

  # GET /order_lists/1
  # GET /order_lists/1.json
  def show
  end

  # GET /order_lists/new
  # GET /order_lists/new.json
  def new
    @order_list = OrderList.new
    authorize @order_list
    @bookstores = Bookstore.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @order_list }
    end
  end

  # GET /order_lists/1/edit
  def edit
    @bookstores = Bookstore.all
  end

  # POST /order_lists
  # POST /order_lists.json
  def create
    @order_list = OrderList.new(order_list_params)
    authorize @order_list
    @order_list.user = current_user

    respond_to do |format|
      if @order_list.save
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.order_list'))
        format.html { redirect_to(@order_list) }
        format.json { render :json => @order_list, :status => :created, :location => @order_list }
      else
        @bookstores = Bookstore.all
        format.html { render :action => "new" }
        format.json { render :json => @order_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /order_lists/1
  # PUT /order_lists/1.json
  def update
    respond_to do |format|
      if @order_list.update_attributes(order_list_params)
        @order_list.sm_order! if params[:mode] == 'order'
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.order_list'))
        format.html { redirect_to(@order_list) }
        format.json { head :no_content }
      else
        @bookstores = Bookstore.all
        format.html { render :action => "edit" }
        format.json { render :json => @order_list.errors, :status => :unprocessable_entity }
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
  def set_order_list
    @order_list = OrderList.find(params[:id])
    authorize @order_list
  end

  def order_list_params
    params.require(:order_list).permit(
      :user_id, :bookstore_id, :title, :note, :ordered_at
    )
  end
end
