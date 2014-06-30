class SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
  	respond_to do |format|
  		format.html {
		    self.resource = warden.authenticate!(auth_options)
		    set_flash_message(:notice, :signed_in) if is_flashing_format?
		    sign_in(resource_name, resource)
		    yield resource if block_given?
		    respond_with resource, location: after_sign_in_path_for(resource)
		  }
			format.js {
				flash[:notice] = "Signed in."
				render :template => "remote_content/devise_success_sign_up.js.erb"
				flash.discard
				sign_in(resource_name, resource)
			}
  	end
  end

end