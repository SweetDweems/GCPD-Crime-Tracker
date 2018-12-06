class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :check_login
  authorize_resource

  def new
    @user = User.new
  end

  def edit
    if !current_user.role.nil? @user.role = current_user.role
  end

  def create
    @user = User.new(user_params)
    if !current_user.role.nil? @user.role = current_user.role
    if @user.save
      flash[:notice] = "Successfully added #{@user.username} as a user."
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated #{@user.username}."
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_url, notice: "Successfully removed #{@user.username} from the GCPD system."
    else
      render action: 'show'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :role, :password, :password_confirmation, :active)
    end
end