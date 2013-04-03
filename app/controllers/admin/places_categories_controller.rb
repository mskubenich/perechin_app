class Admin::PlacesCategoriesController < ApplicationController
  def index
    @title = "Places Categories"
    @categories = PlacesCategory.all
  end

  def new
    @title = "Create POI Category"
    @category = PlacesCategory.new
  end

  def create
    @category = PlacesCategory.new(params[:places_category])
    if @category.save
      flash[:success] = "Succesfully created POI category: " + @category.name
      redirect_to admin_places_categories_path
    else
      flash[:success] = "Error created POI category"
      render 'new'
    end
  end

  def edit
    @title = "Edit POI Category"
    @category = PlacesCategory.find params[:id]
  end

  def update
    @category = PlacesCategory.find(params[:id])
    if @category.update_attributes params[:places_category]
      flash[:success] = "Succesfully updated POI category: " + @category.name
      redirect_to admin_places_categories_path
    else
      flash[:success] = "Error updated POI category"
      render 'edit'
    end
  end

  def destroy
    PlacesCategory.find(params[:id]).destroy
    redirect_to admin_places_categories_path
  end

end
