class News < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :user

  attr_accessible :body, :title, :attached_assets, :source, :preview

  validates :title, :presence => true
  validates :body, :presence => true
  validates :source, :presence => true
  validates :preview, :presence => true

  def self.search(page = 1)
    items_per_page = 10
    paginate :per_page => items_per_page, :page => page, :order => 'created_at DESC'
  end


end
