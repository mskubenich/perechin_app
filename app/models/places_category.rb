class PlacesCategory < ActiveRecord::Base
  has_many :showplaces
  attr_accessible :name
end
