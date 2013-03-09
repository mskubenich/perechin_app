class ArtsController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
    @art_subcategory = ArtSubcategory.find(params[:art_subcategory]) if params[:art_subcategory]
    role_author = Role.find_by_name("author")
    @authors = User.where(:role_id => role_author.id)
  end
end
