class Admin::InventoryController < ApplicationController
  protect_from_forgery

  def index
    @orders = Order.includes(items: [:patch_type])
    @current_status = params[:filter] || 'all'
  end
end
