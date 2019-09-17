class Admin::DashboardController < ApplicationController
  protect_from_forgery
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == ENV['HTTP_USER'] && password == ENV['HTTP_PASS']
    end
  end

  def index
    @order_count = Order.confirmed.size
    @order_max = Order.pending_approval.size
    @ratio = (@order_max + 1) / (@order_max + @order_count + 1)
  end

  def order_form
    @orders = Order.order_form
    @descriptions = PatchType.descriptions
    @rows = []

    max_size = @orders.values.map(&:size).max

    max_size.times do |i|
      row = []

      @orders.each do |_, items|
        row << items[i]
      end

      @rows << row
    end
  end
end
