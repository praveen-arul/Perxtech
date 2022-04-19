# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  # Permiting params for signup
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth, :country, :password,
                                 :password_confirmation)
  end

  # Permiting params on updating user
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :country,
                                 :date_of_birth, :password_confirmation, :current_password)
  end
end
