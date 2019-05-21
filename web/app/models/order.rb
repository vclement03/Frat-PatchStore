require 'securerandom'

class Order < ApplicationRecord
  before_create :set_token
  enum status: [:unconfirmed, :waiting_for_payment, :pending_approval, :confirmed, :ordered, :ready_for_pickup, :archived]

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :full_name, presence: true

  has_many :items

  before_create do
    self.status = :unconfirmed
  end

  def to_param
    token
  end

  def set_token
    self.token = SecureRandom.hex(32)
  end

  def total_price
    @total_price ||= items.size * Config.get('custom_patch_price').to_i
  end

  def total_refund
    @total_refund ||= items.refused.size * Config.get('custom_patch_price').to_i
  end

  def confirm_order!
    self.confirmed!
  end

  def self.order_form
    orders = Order.confirmed.includes(items: [:patch_type])
    patch_types = Hash.new { |h, k| h[k] = [] }

    orders.each do |order|
      order.items.each do |item|
        next if item.refused?

        if item.patch_type.name == 'plain'
          odd = item.odd? ? '_odd' : '_even'
          patch_types[item.patch_type.name + odd] << item
        else
          patch_types[item.patch_type.name] << item
        end
      end
    end

    patch_types
  end
end
