class Work < ActiveRecord::Base
  belongs_to :author, :class_name => "User" , :foreign_key => "user_id"
  belongs_to :art_subcategory
  attr_accessible :art_subcategory_id, :body, :title, :author, :user_id
  validates :title, :presence => true
  validates :body, :presence => true
  validates :art_subcategory_id, :presence => true
end
