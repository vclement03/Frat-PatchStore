json.extract! order, :id, :transaction_id, :email, :status, :token, :full_name, :created_at, :updated_at
json.url order_url(order, format: :json)
