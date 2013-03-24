class MapsController < ApplicationController
  def index
    @json = Showplace.all.to_gmaps4rails
  end
end
