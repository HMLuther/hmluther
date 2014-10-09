class RegistrationsController < Devise::RegistrationsController

  before_action :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :address, :city, :country, :phone, :state, :zip, :reference => [])}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :address, :city, :country, :phone, :state, :zip, :reference => [])}
  end

	def create
		build_resource(sign_up_params)

		if resource.save
			respond_to do |format|
				format.html {
					yield resource if block_given?
					if resource.active_for_authentication?
						set_flash_message :notice, :signed_up if is_flashing_format?
						sign_up(resource_name, resource)
						respond_with resource, :location => after_sign_up_path_for(resource)
					else
						set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
						expire_data_after_sign_in!
						respond_with resource, :location => after_inactive_sign_up_path_for(resource)
					end
				}
				format.js {
					flash[:notice] = "Created account, signed in."
					render :template => "remote_content/devise_success_sign_up.js.erb"
					flash.discard
					sign_up(resource_name, resource)
				}
			end

		else
			respond_to do |format|
				format.html {
					clean_up_passwords resource
					respond_with resource
				}
				format.js {
					flash[:alert] = @user.errors.full_messages.to_sentence
					render :template => "remote_content/devise_errors.js.erb"
					flash.discard
				}
			end

		end
	end

  protected
  
	def after_sign_up_path_for(resource)
	  signed_in_root_path(resource)
	end

	def after_update_path_for(resource)
	  signed_in_root_path(resource)
	end
	
end