class RegistrationsController < Devise::RegistrationsController

  def new
    redirect_to new_subscription_path
  end

  def create
    redirect_to new_subscription_path
  end

  def update
	self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

	if resource.update_with_password(account_update_params)
		sign_in resource_name, resource, bypass: true
		flash[:notice] = 'Your account was updated!'
		respond_with resource, location: after_update_path_for(resource)
	else
		clean_up_passwords resource
		render 'edit'
	end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, {:category_ids => []})
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, {:category_ids => []})
  end
end
