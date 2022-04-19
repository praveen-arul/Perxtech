# frozen_string_literal: true

every :day, at: '12:00 pm' do
  rake 'rewards:providing_movie_rewards', output: 'log/rake_status.log'
  rake 'rewards:providing_5percent_cash_rewards', output: 'log/rake_status.log'
  rake 'expiring_rewards:after_1year', output: 'log/rake_status.log'
end

every :month, at: '12:00 pm' do
  rake 'rewards:providing_coffee_rewards', output: 'log/rake_status.log'
end

every 3.months, at: '12:00 pm' do
  rake 'loyalty_points:providing_bonus', output: 'log/rake_status.log'
end

every 1.year, at: '12:00 pm' do
  rake 'loyalty_points:expiring', output: 'log/rake_status.log'
end
