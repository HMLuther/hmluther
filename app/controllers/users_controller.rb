class UsersController < ApplicationController
  
  before_action :authenticate_user!, unless: :json_request?
  before_action :authenticate_api_user, only: [:create, :edit, :update, :destroy], if: :json_request?
  after_action :verify_authorized, except: [:show], unless: :json_request?

  def index
    @users = User.all.order('last_name ASC')
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
