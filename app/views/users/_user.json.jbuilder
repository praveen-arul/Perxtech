json.extract! user, :id, :first_name, :last_name, :total_loyalty_points, :date_of_birth, :tier, :country, :created_at, :updated_at
json.url user_url(user, format: :json)
