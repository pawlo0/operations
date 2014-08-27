class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    if params[:user][:password] == "1111"
      respond_with resource, location: edit_user_registration_path(resource)
      flash[:alert] ||= "Deve alterar a sua password" 
    else
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
  
end