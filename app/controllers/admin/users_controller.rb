class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    @roles = Role.where("roles.name != 'admin' AND roles.name != 'guest'")
  end

  def change_user_role
    user = User.find(params[:user_id])
    role = Role.find(params[:new_role_id])
    if user.role.name != "admin" && role.name != "admin"
      user.update_attribute(:role_id, role.id)
      render :text => "Succesfully changed "+user.name + " role to " + role.name
    else
      render :text => "permitions error"
    end
  end
end
