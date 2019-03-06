class RegistrationsController < Devise::RegistrationsController
 
  private
 
  # Modified Devise params for user login
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end

  def after_sign_up_path_for(resource)
    "/profiles/"
  end

  def after_sign_in_path_for(resource_or_scope)
    # session[:my_account] = current_user.account
    # profile_url
    "/profiles/"
  end

  def after_inactive_sign_up_path_for(resource)
    "/profiles/new"
  end

end