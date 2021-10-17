class ProfilesController < ApplicationController
  def show_profile
    if freelancer_user_signed_in?
      @profile = Profile.find(current_freelancer_user[:id])
    else
      @proposal = Proposal.find(params[:id])
      @profile = @proposal.freelancer_user.profile
    end
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.freelancer_user = current_freelancer_user
    if @profile.save
      redirect_to show_profile_path, notice: 'Perfil criado!'
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:fullname, :socialname, :birthdate, :education, :description, :experience)
  end
end