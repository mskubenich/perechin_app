class Admin::PopulatedPlacesController < ApplicationController

  def index
    @places = PopulatedPlace.all
    @title = "Populated places"
  end

  def new
    @title = "Create Populated Place"
    @place = PopulatedPlace.new
  end

  def create
    @place = PopulatedPlace.create(params[:populated_place])
    if @place.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(params[:populated_place][:description])
      page.xpath("//img[@asset]").each do |img|
        if params[:images] && params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:populated_place_id => @place.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @place.description = page.css("body:first").inner_html

      @place.save
      flash[:success] = "Succesfully created place: " + @place.title
      redirect_to admin_populated_places_path
    else
      flash[:success] = "Error created place"
      render 'new'
    end
  end

  def edit
    #@title = "Edit role"
    #@tag = Tag.find params[:id]
  end

  def update
    #@tag = Tag.find params[:id]
    #if @tag.update_attributes params[:tag]
    #  redirect_to admin_tags_path, notice: 'Tag was successfully updated.'
    #else
    #  render "edit"
    #end
  end

  def destroy
    #Tag.find(params[:id]).destroy
    #redirect_to admin_tags_path
  end

end
