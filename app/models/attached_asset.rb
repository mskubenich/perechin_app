class AttachedAsset < ActiveRecord::Base
  belongs_to :news
  has_attached_file :asset, :styles => { :medium => "1000x300>", :small => "100x100>" },
                    :url  => "/assets/news/news/:id/:style/:basename.:extension",
                    :default_url => "/assets/noavatar.gif",
                    :path => ":rails_root/app/assets/images/news/news/:id/:style/:basename.:extension"
  attr_accessible :asset, :news_id
end
