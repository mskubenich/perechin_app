class Admin::ArtsController < ApplicationController
  def index
    @art_categories = ArtCategory.all
  end

  def new
    @title = "Create Art Category"
    @art_category = ArtCategory.new
  end

  def create
    @art_category = ArtCategory.new(params[:art_category])
    if @art_category.save
      flash[:success] = "Succesfully created arts category: " + @art_category.title
      redirect_to admin_arts_path
    else
      flash[:success] = "Error created arts category"
      render 'new'
    end
  end

  def edit
    @title = "Edit arts category"
    @art_category = ArtCategory.find params[:id]
  end

  def update
    @art_category = ArtCategory.find params[:id]
    if @art_category.update_attributes params[:art_category]
      redirect_to admin_arts_path, notice: 'Art category was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    ArtCategory.find(params[:id]).destroy
    redirect_to admin_arts_path
  end

  def approve_work
    work = Work.find(params[:id])
    work.update_attribute(:moderate, true)
    render :text => :success
  end

end
