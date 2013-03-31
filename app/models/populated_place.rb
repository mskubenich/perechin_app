class PopulatedPlace < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  attr_accessible :description, :title
  validates :title, :presence => true
end
