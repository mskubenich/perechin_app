class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news
  belongs_to :article
  belongs_to :work

  attr_accessible :news_id, :text, :user_id, :article_id, :work_id

  validates :text, :presence => true
  validates :user_id, :presence => true
end
