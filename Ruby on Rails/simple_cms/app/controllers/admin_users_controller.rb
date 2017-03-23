class AdminUsersController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @admin_users = AdminUser.sorted
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "User Added Successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = "User Updated Successfully"
      redirect_to(:action => 'index')
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    admin_user = AdminUser.find(params[:id])
    admin_user.destroy
    flash[:notice] = "#{admin_user.username} Deleted Successfully"
    redirect_to(:action => 'index')
  end

  private
  def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password)
  end
end
