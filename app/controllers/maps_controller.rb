#encoding: utf-8

class MapsController < ApplicationController
  def index
    @title = "Перечинщина на мапі. Заклади, цікаві місця"
    @poi = Showplace.search(params[:page], params[:category], params[:sity])
    @json = @poi.to_gmaps4rails do |place,marker|
      marker.infowindow render_to_string(:partial => 'infowindow', :locals => {:place => place})
    end

    @options = {
      :map_options => { :auto_adjust => true,
                        :type => "HYBRID",
                        :zoom => 12 },
      :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
  end

  def populated_place
    @place = PopulatedPlace.find(params[:id])
    @title = @place.title + " на мапі. Заклади, цікаві місця"
    params[:sity] = @place.id
    @poi = Showplace.search(params[:page], params[:category], params[:sity])
    @json = @poi.to_gmaps4rails do |place,marker|
      marker.infowindow render_to_string(:partial => 'infowindow', :locals => {:place => place})
    end


    @options = {
        :map_options => { :auto_adjust => true,
                          :type => "HYBRID",
                          :zoom => 12 },
        :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
  end

  def showplace
    @place = Showplace.find(params[:id])
    @title = @place.name
    params[:category] = @place.places_category_id
    params[:sity] = @place.populated_place_id
  end

  def new_showplace
    @showplace = Showplace.new
    @title = "Додати цікаве місце"
  end

  def create_showplace
    real_desc = params[:showplace][:description]
    params[:showplace][:description] = "qwerty"

    @showplace = Showplace.create(params[:showplace])
    if @showplace.save
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(real_desc)
      page.xpath("//img[@asset]").each do |img|
        if params[:images] && params[:images]['asset'+img['assetnum']]
          image = AttachedAsset.create(:showplace_id => @showplace.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @showplace.description = page.css("body:first").inner_html

      @showplace.save
      flash[:success] = "Succesfully created showplace: " + @showplace.name
      redirect_to maps_path
    else
      @showplace.description = real_desc
      flash[:success] = "Error created showplace"
      render 'new_showplace'
    end
  end

  def edit_showplace
    @showplace = Showplace.find(params[:id])
    @title = "Редагування запису"
  end

  def update_showplace
    real_desc = params[:showplace][:description]
    params[:showplace][:description] = "qwerty"

    @showplace = Showplace.find(params[:id])
    if @showplace.update_attributes(params[:showplace])
      #save attached images
      require 'nokogiri'
      page =  Nokogiri::HTML(real_desc)

      @showplace.attached_assets.each do |image|
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
          image = AttachedAsset.create(:showplace_id => @showplace.id, :asset => params[:images]['asset'+img['assetnum']])
          img.attribute('src').value = image.asset.url(:original)
          img['asset_id'] = image.id.to_s
          params[:images].delete('asset'+img['assetnum'])
          img.remove_attribute 'assetnum'
          img.remove_attribute 'asset'
        end
      end
      @showplace.description = page.css("body:first").inner_html

      @showplace.save
      flash[:success] = "Succesfully changed showplace: " + @showplace.name
      redirect_to maps_path
    else
      @showplace.description = real_desc
      flash[:success] = "Error changed showplace"
      render 'new_showplace'
    end
  end

  def destroy_showplace
    Showplace.find(params[:id]).destroy
    redirect_to maps_path
  end

end
