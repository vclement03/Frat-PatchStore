class Admin::InventoryController < ApplicationController
  def index
    @orders = Order.includes(items: [:patch_type])
    @current_status = params[:filter] || 'all'
  end
end
