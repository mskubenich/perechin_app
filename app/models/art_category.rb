class ArtCategory < ActiveRecord::Base
  has_many :art_subcategories, :dependent => :destroy
  attr_accessible :title
  validates :title, :presence => true
end
