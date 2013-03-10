class ArtSubcategory < ActiveRecord::Base
  belongs_to :art_category
  has_many :works
  attr_accessible :art_category_id, :title
  validates :title, :presence => true
  validates :art_category_id, :presence => true
end
