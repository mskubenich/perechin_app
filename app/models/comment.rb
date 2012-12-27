class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news

  attr_accessible :news_id, :text, :user_id

  validates :text, :presence => true
  validates :news_id, :presence => true
  validates :user_id, :presence => true
end
