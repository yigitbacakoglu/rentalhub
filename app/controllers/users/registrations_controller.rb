# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    (params[:user][:role] = "Tenant" if params[:user][:role] == 'Admin') rescue ''
    if params[:user]
    nested_keys = params.require(:user).fetch(:profile_attributes, {}).keys
    devise_parameter_sanitizer.for(:sign_up).push(:username, :email, :role, profile_attributes: nested_keys)
    devise_parameter_sanitizer.for(:account_update).push(:username, :email, profile_attributes: nested_keys)
     end
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    self.resource.role = params[:r] if hash.blank?
    self.resource.build_profile if self.resource.profile.blank?
  end


  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    backend_profile_path
  end




end
