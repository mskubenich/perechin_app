class PopulatedPlace < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  has_many :showplaces
  attr_accessible :description, :title
  validates :title, :presence => true
end
