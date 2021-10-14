class UsersController < ApplicationController
  def my_profile
      @user = current_freelancer_user
  end
end