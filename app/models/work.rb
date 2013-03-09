class Work < ActiveRecord::Base
  attr_accessible :art_subcategory_id, :body, :title, :user_id
  validates :title, :presence => true
  validates :body, :presence => true
end
