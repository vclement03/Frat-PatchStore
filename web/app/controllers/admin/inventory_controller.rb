class Admin::InventoryController < ApplicationController
  protect_from_forgery
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == ENV['HTTP_USER'] && password == ENV['HTTP_PASS']
    end
  end

  def index
    @orders = Order.includes(items: [:patch_type])
    @current_status = params[:filter] || 'all'
  end
end
