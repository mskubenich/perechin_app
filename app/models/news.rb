class News < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :user

  attr_accessible :body, :title, :attached_assets, :source, :preview

  validates :title, :presence => true
  validates :body, :presence => true, :length => {:minimum => 200}
  validates :source, :presence => true
  validates :preview, :presence => true

  def assets_array=(array)
    array.each do |file|
      attached_assets.build(:asset => file[:asset])
    end
  end
end
