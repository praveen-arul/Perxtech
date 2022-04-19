# frozen_string_literal: true

class UsersRewardsController < ApplicationController
  # GET /rewards
  def index
    @user_rewards = current_user.user_rewards
  end
end
