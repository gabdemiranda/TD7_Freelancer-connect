class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(1)
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.freelancer_user = current_freelancer_user
    if @profile.save
      redirect_to [@profile], notice: 'Perfil atualizado'
    else
      render :new
    end
  end

  private

  def profile_params 
    params.require(:profile).permit( :fullname, :socialname, :birthdate, :education, :description, :experience )
  end
end