class AttachedAsset < ActiveRecord::Base
  belongs_to :news
  belongs_to :article
  belongs_to :work
  belongs_to :anecdote
  has_attached_file :asset, :styles => { :original => "1000x1000>" },
                    :url  => "/assets/news/:id/:style/:basename.:extension",
                    :path => ":rails_root/app/assets/images/news/:id/:style/:basename.:extension"
  attr_accessible :asset, :news_id, :article_id, :work_id
end
