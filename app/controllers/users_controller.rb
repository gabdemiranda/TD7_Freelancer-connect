class UsersController < ApplicationController
  def my_profile
    if regular_user_signed_in?
      @user = current_regular_user
    elsif freelancer_user_signed_in?
      @user = current_freelancer_user
    end
  end
end