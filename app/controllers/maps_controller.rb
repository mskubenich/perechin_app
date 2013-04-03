class MapsController < ApplicationController
  def index
    @poi = Showplace.all
    @json = @poi.to_gmaps4rails

    @options = {
      :map_options => { :auto_adjust => true,
                        :type => "HYBRID",
                        :zoom => 12 },
      :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
    @places = PopulatedPlace.all
    @places_categories = PlacesCategory.all
  end

  def populated_place
    @place = PopulatedPlace.find(params[:id])
    @places = PopulatedPlace.all
    @places_categories = PlacesCategory.all
  end

end
