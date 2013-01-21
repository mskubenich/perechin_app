class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news
  belongs_to :article

  attr_accessible :news_id, :text, :user_id, :article_id

  validates :text, :presence => true
  validates :user_id, :presence => true
end
