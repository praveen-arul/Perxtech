namespace :rewards do
  desc "providing rewards for the users based on rule sets"

  task providing_coffee_rewards: :environment do
    @user_rewards = []
    @users = User.joins(:transactions).where('transactions.created_at BETWEEN ? AND ?', 
      DateTime.now.beginning_of_month, DateTime.now.end_of_month).group(:id)
      .having('SUM(transactions.points_generated) >= ? OR extract(month from date_of_birth) = ?', 100, DateTime.now.month)

    create_user_rewards(coffee_reward)
  end

  task providing_movie_rewards: :environment do
    @user_rewards = []
    @users = User.joins(:transactions).where('users.created_at >= ?',
                                            Date.today - 60.days).group('users.id').select("MIN(transactions.created_at) as created_at, users.id").where('transactions.amount >= 1000')

    create_user_rewards(movie_reward)
  end

  task providing_5percent_cash_rewards: :environment do
    @user_rewards = []
    @users = User.joins(:transactions).group(:id).having('count(transactions.amount > 100) >= 10')

    create_user_rewards(cash_rebate)
  end

  def coffee_reward
    Reward.find_or_create_by(name: 'Free Coffee Reward')
  end

  def movie_reward
    Reward.find_or_create_by(name: 'Free Movie Ticket')
  end

  def cash_rebate
    Reward.find_or_create_by(name: '5% Cash Rebate')
  end

  def create_user_rewards(reward)
    @users.each do |user|
      @user_rewards << UserReward.new(user: user, reward: reward)
    end
    UserReward.import(@user_rewards, on_duplicate_key_ignore: true)
  end
end
