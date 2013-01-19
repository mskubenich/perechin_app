class Admin::RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find params[:id]
  end

  def new
    @title = "Create Tag"
    @role = Tag.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:success] = "Succesfully created role: " + @role.name
      redirect_to admin_roles_path
    else
      flash[:success] = "Error created news"
      render 'new'
    end
  end

  def edit
    @title = "Edit role"
    @role = Role.find params[:id]
  end

  def update
    @role = Role.find params[:id]
    if @role.update_attributes params[:role]
      redirect_to admin_roles_path, notice: 'Role was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    Role.find(params[:id]).destroy
    redirect_to admin_roles_path
  end
end
