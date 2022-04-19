namespace :loyalty_points do
  desc "providing bonus points and expiring loyalty points for the users"

  # Task to provide Bonus points for the customer
  task providing_bonus: :environment do
    User.joins(:transactions).where('transactions.created_at BETWEEN ? AND ? and transactions.amount >= ?',
      Date.today.beginning_of_quarter, Date.today.end_of_quarter, 2000).update_all('total_loyalty_points = (total_loyalty_points + 100)')
  end

  # Task to expire loyalty points for the user
  task expiring: :environment do
    User.where('created_at <= ?', Date.today - 1.year).update_all(total_loyalty_points: 0)
  end
end
