class News < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  attr_accessible :body, :title, :attached_assets

  validates :title, :presence => true
  validates :body, :presence => true

  def assets_array=(array)
    array.each do |file|
      attached_assets.build(:asset => file[:asset])
    end
  end
end
