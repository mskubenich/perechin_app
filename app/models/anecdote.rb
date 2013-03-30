class Anecdote < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  attr_accessible :body, :title

  validates :title, :presence => true
  validates :body, :presence => true

  def self.search(page = 1)
    items_per_page = 10
    paginate :per_page => items_per_page, :page => page,
             :order => 'created_at DESC'
  end
end
