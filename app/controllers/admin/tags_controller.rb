class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @title = "Create Tag"
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:success] = "Succesfully created tag: " + @tag.title
      redirect_to admin_tags_path
    else
      flash[:success] = "Error created tag"
      render 'new'
    end
  end

  def edit
    @title = "Edit role"
    @tag = Tag.find params[:id]
  end

  def update
    @tag = Tag.find params[:id]
    if @tag.update_attributes params[:tag]
      redirect_to admin_tags_path, notice: 'Tag was successfully updated.'
    else
      render "edit"
    end
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_path
  end

  def tags_for_autocomplete
    @tags = Tag.all(:conditions => ['title LIKE ?', '%'+params[:keyword]+'%'])
    render :partial => 'tags_for_autocomplete'
  end

end
