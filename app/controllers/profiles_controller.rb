class ProfilesController < ApplicationController
  def show
    id = params[:id]
    @profile = Profile.find(id)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to @profile
    else
      render :new
    end
  end

  def profile_params 
    params.require(:profile).permit(:fullname, :socialname, :birthdate, :education, :description, :experience )
  end
end