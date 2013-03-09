class ArtsController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
    @art_subcategory = ArtSubcategory.find(params[:art_subcategory]) if params[:art_subcategory]
    role_author = Role.find_by_name("author")
    @authors = User.where(:role_id => role_author.id)
    @works = Work.all
  end

  def show
    @work = Work.find params[:id]
  end

  def new
    @title = "Create Work"
    @work = Work.new
  end

  def create
    redirect_to admin_roles_path
    #@role = Role.new(params[:role])
    #if @role.save
    #  flash[:success] = "Succesfully created role: " + @role.name
    #  redirect_to admin_roles_path
    #else
    #  flash[:success] = "Error created news"
    #  render 'new'
    #end
  end

  def edit
    @title = "Edit role"
    @role = Role.find params[:id]
  end

  def update
    redirect_to admin_roles_path
    #@role = Role.find params[:id]
    #if @role.update_attributes params[:role]
    #  redirect_to admin_roles_path, notice: 'Role was successfully updated.'
    #else
    #  render "edit"
    #end
  end

  def destroy
    redirect_to admin_roles_path
    #Role.find(params[:id]).destroy
    #redirect_to admin_roles_path
  end
end
