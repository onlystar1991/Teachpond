class UsersController < ApplicationController
  before_filter :require_permission, only: :edit
  before_action :find_user, only: [:show]
  before_action :find_profile, only: [:show]

  def show
    @first_name = @profile.first_name ? @profile.first_name : ''
    @last_name = @profile.last_name ? @profile.last_name : ''
    @city = @profile.city ? @profile.city : ''
    @country = @profile.country ? @profile.country : ''
    @posts = @user.posts ? @user.posts : ''
    @requests = @user.requests ? @user.requests : ''
    @active_tab = 0
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def find_profile
      @profile = Profile.find_by user_id: (params[:id])
    end

    def require_permission
      if current_user != User.find(params[:id])
        redirect_to new_user_session_path
      end
    end
end