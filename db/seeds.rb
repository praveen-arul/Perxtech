# frozen_string_literal: true

require 'faker'
include FactoryBot::Syntax::Methods

# Creating test user for login
user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: 'perxtech@gmail.com', password: 'Perxtech@123',
                   date_of_birth: Faker::Date.in_date_period, country: User::DEFAULT_COUNTRY)

# Creating basic Rewards
rewards = [{ name: 'Free Coffee_Reward' }, { name: 'Free Movie ticket' }, { name: 'Airport Lounge Access Reward' }, { name: '5% Cash Rebate' }]

Reward.create(rewards)

# Creating 20 test users
create_list :user, 10, :default_country

create_list :user, 10, :other_countries

# Creating 10 transactions for the users
create_list :transaction, 10, user_id: user.id
