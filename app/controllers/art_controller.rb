class ArtController < ApplicationController
  def index
    @title = "Art"
    @art_categories = ArtCategory.all
  end
end
