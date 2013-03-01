class Admin::ArtSubcategoriesController < ApplicationController

  def index
    @art_categories = ArtCategory.all
  end

  def new
    @title = "Create Art Subcategory"
    @art_subcategory = ArtSubcategory.new
    @art_categories = ArtCategory.all
  end

  def create
    @art_subcategory = ArtSubcategory.new(params[:art_subcategory])
    if @art_subcategory.save
      flash[:success] = "Succesfully created art subcategory: " + @art_subcategory.title
      redirect_to admin_art_subcategories_path
    else
      flash[:success] = "Error created art_category"
      render 'new'
    end
  end

  def edit
    @title = "Edit art subcategory"
    @art_subcategory = ArtSubcategory.find params[:id]
    @art_categories = ArtCategory.all
  end

  def update
    @art_subcategory = ArtSubcategory.find params[:id]
    if @art_subcategory.update_attributes params[:art_subcategory]
      redirect_to admin_art_subcategories_path, notice: 'Art Category  was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    ArtSubcategory.find(params[:id]).destroy
    redirect_to admin_art_subcategories_path
  end

end
