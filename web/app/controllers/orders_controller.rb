# coding: utf-8
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :pay, :check]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @items = @order.items.to_a

    if @order.unconfirmed?
      render :unconfirmed
    else
      render :confirmed
    end
  end

  # GET /orders/new
  def new
    @order = Order.new

    # Also create item
    # Si ca marche, fais juste sauvegarder toutes
    # les infos dans un object quelconque
    @item = Item.new

  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    # Check comment get tes items de l'object
    #@item = Item.new(item_params)

    respond_to do |format|
      if @order.save
        #apres avoir sauvegarder ton order, link le aux items que tu veux creer
        # si t'en cree plusieurs, mets les dans un array d'objects pis itere à travers
        # pour les sauvegarder
        # item = @item
        #item.order = @order.id
        # item.save
        format.html { redirect_to @order, notice: @order.items }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check
    checkout_api = SquareConnect::CheckoutApi.new

    locations_api = SquareConnect::LocationsApi.new
    locations = locations_api.list_locations.locations
    location_id = locations.first.id

    api = SquareConnect::TransactionsApi.new
    t = api.retrieve_transaction(location_id, params[:transactionId])

    if t.transaction.tenders[0].card_details.status == 'CAPTURED'
      @order.pending_approval!
      flash[:notice] = 'Votre commande a été payé.'
    else
      flash[:error] = "Votre commande n'a pas été payé"
    end

    redirect_to order_path(@order)
  end

  def pay
    checkout_api = SquareConnect::CheckoutApi.new

    locations_api = SquareConnect::LocationsApi.new
    locations = locations_api.list_locations.locations
    location_id = locations.first.id

    body = SquareConnect::CreateCheckoutRequest.new
    body.ask_for_shipping_address = false
    body.idempotency_key = "allo" + rand.to_s
    body.pre_populate_buyer_email = @order.email
    body.redirect_url = order_check_url(@order)

    body.order = SquareConnect::Order.new
    body.order.location_id = location_id
    body.order.reference_id = body.idempotency_key

    body.order.line_items = []

    @order.items.each do |item|
      line_item = SquareConnect::OrderLineItem.new

      line_item.name = "Écusson"
      line_item.quantity = "1"
      line_item.note = item.full_text
      line_item.base_price_money = SquareConnect::Money.new(amount: Config.get('custom_patch_price').to_i * 100, currency: "CAD")

      body.order.line_items << line_item
    end

    result = checkout_api.create_checkout(location_id, body)

    redirect_to result.checkout.checkout_page_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find_by!(token: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:transaction_id, :email, :status, :token, :full_name)
    end
end
