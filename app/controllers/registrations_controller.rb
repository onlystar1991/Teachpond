class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    edit_user_profile_path(current_user.id, current_user.profile.id)
  end
end
