class ArtsController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
    @category = ArtCategory.find(params[:art_category]) if params[:art_category]
  end
end
