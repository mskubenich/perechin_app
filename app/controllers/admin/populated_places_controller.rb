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
    real_desc = params[:populated_place][:description]
    params[:populated_place][:description] = "qwerty"

    @place = PopulatedPlace.create(params[:populated_place])
    if @place.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(real_desc)
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
      @place.description = real_desc
      flash[:success] = "Error created place"
      render 'new'
    end
  end

  def edit
    @title = "Edit Populated Place"
    @place = PopulatedPlace.find(params[:id])
  end

  def update
    real_desc = params[:populated_place][:description]
    params[:populated_place][:description] = "qwerty"

    @place = PopulatedPlace.create(params[:populated_place])
    if @place.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(real_desc)

      @place.attached_assets.each do |image|
        image_present = false
        page.xpath("//img[@asset_id=#{image.id.to_s}]").each do |img|
          image_present = true
        end
        unless image_present
          image.destroy
        end
      end

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
      @place.description = real_desc
      flash[:success] = "Error created place"
      render 'new'
    end
  end

  def destroy
    PopulatedPlace.find(params[:id]).destroy
    redirect_to admin_populated_places_path
  end

end
