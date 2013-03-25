class MapsController < ApplicationController
  def index
    @json = Showplace.all.to_gmaps4rails

    @options = {
      :map_options => { :auto_adjust => false,
                        :type => "HYBRID",
                        :center_latitude => 48.735588,
                        :center_longitude => 22.475967,
                        :zoom => 12 },
      :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
  end
end
