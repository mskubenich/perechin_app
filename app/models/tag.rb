class Tag < ActiveRecord::Base
  has_and_belongs_to_many :news
  attr_accessible :title
  validates :title, :presence => true
end
