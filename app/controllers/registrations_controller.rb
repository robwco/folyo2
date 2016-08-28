class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show]
  before_filter :set_selected_categories, only: [:edit]

  def new
    redirect_to new_subscription_path
  end

  def create
    redirect_to new_subscription_path
  end

  def show
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_without_password(account_update_params)
      sign_in resource_name, resource, bypass: true
      flash[:notice] = 'Your account was updated!'
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      @selected_categories = Category.find(@user.category_ids)
      render 'edit'
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, {:category_ids => []})
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :biography, :photo, :location, :account_type, 
          :password, :password_confirmation, :company_logo, :company_name, :company_website, :company_biography, 
          {:category_ids => []})
    end

    def set_selected_categories
        @selected_categories = Category.find(@user.category_ids)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
