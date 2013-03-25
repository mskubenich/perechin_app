class MapsController < ApplicationController
  def index
    @json = Showplace.all.to_gmaps4rails

    @options = {
      :map_options => { :auto_adjust => true,
                        :type => "HYBRID",
                        :center_latitude => 48.735588,
                        :center_longitude => 22.475967,
                        :auto_adjust => false,
                        :zoom => 10 },
      :markers     => { :data => @json, :options => {:do_clustering => true} }
    }
  end
end
