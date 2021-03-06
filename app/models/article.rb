class Article < ActiveRecord::Base
  has_many :attached_assets, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_and_belongs_to_many :tags

  attr_accessible :body, :title, :attached_assets, :source

  validates :title, :presence => true
  validates :body, :presence => true
  validates :source, :presence => true

  def self.search(page = 1, tag)
    items_per_page = 10
    conditions = [" id > 0 "]
    if tag
      paginate :per_page => items_per_page, :page => page,
               :conditions => ["tags.id = " + tag],
               :joins => :tags,
               :order => 'created_at DESC'
    else
      paginate :per_page => items_per_page, :page => page,
               :order => 'created_at DESC'
    end
  end


  def self.tags
    tags = ActiveRecord::Base.connection.select_all("SELECT tags.id, tags.title,
                            (SELECT count(id) FROM articles_tags WHERE tag_id = tags.id) AS totalcount
                            FROM tags HAVING totalcount > 0
                            ORDER BY totalcount DESC LIMIT 30;")
    if tags.blank?
      return tags
    end
    max_size = 35
    min_size = 15
    max_value = tags.first['totalcount'].to_i
    min_value = tags.last['totalcount'].to_i
    if max_value == 0 || max_value == min_value
      return tags
    end
    tags.each do |tag|
      tag['size'] = (((tag['totalcount'].to_i - min_value)*(max_size - min_size))/(max_value - min_value))+min_size
    end

    max_opacity = 1.0
    min_opacity = 0.3
    tags.each do |tag|
      tag['opacity'] = (((tag['totalcount'].to_i - min_value)*(max_opacity - min_opacity))/(max_value - min_value))+min_opacity
    end

    tags.sort_by{ |tag| tag['id'] }
  end

end
