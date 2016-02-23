class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find_by user_id: (params[:id])
  end

  def update
    @profile = Profile.find_by user_id: (params[:id])
    if @profile.update(profile_params)
      redirect_to user_path, :flash => { :success => "Your profile is successfuly updated" }
    else
      render 'edit'
    end
  end
  def show
    @profile = Profile.find_by user_id: (params[:id])
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :city, :country, :avatar)
    end
end