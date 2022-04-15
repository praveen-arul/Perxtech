json.extract! transaction, :id, :amount, :points_generated, :payment_mode, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
