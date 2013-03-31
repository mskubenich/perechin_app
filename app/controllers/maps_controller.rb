class MapsController < ApplicationController
  def index
    @json = Showplace.all.to_gmaps4rails

    @options = {
      :map_options => { :auto_adjust => true,
                        :type => "HYBRID",
                        :zoom => 12 },
      :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
    @places = PopulatedPlace.all
  end

  def populated_place

  end

end
