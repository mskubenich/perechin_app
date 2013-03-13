class Tag < ActiveRecord::Base
  has_and_belongs_to_many :news
  has_and_belongs_to_many :articles
  attr_accessible :title
  validates :title, :presence => true
end
