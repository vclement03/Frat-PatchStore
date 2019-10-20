# coding: utf-8
class Admin::OrdersController < ApplicationController
  protect_from_forgery

  def index
    @orders = Order.pending_approval.includes(:items)
  end

  def show
    @order = Order.find_by!(id: params[:id])
  end

  def confirm
    @order = Order.pending_approval.find_by!(id: params[:id])
  end

  def complete
    @order = Order.pending_approval.find_by!(id: params[:id])

    @order.confirm_order!

    redirect_to admin_orders_path, notice: 'La commande a été confirmée'
  end

  def edit_item
  end
end
