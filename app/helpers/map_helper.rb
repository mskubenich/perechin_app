module MapHelper
  def populated_places
    PopulatedPlace.all
  end

  def poi_categories
    PlacesCategory.all
  end

end
