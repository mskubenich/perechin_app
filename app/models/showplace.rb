class Showplace < ActiveRecord::Base
  belongs_to :populated_place
  belongs_to :places_category
  has_many :attached_assets, :dependent => :destroy
  acts_as_gmappable :process_geocoding => false
  attr_accessible :name, :preview, :latitude, :longitude, :description, :populated_place_id, :places_category_id
  validates :name, :presence => true
  validates :preview, :presence => true
  validates :longitude, :presence => true, :numericality => true
  validates :latitude, :presence => true, :numericality => true
  validates :populated_place_id, :presence => true
  validates :places_category_id, :presence => true

  def self.search(page = 1, category, sity)
    items_per_page = 10
    conditions = ""
    unless category.to_s.blank?
      cat = category.to_s.gsub /\D/, ""
      conditions += "places_category_id = " + cat
    end
    unless sity.to_s.blank?
      conditions += " AND " if conditions != ""
      sit = sity.to_s.gsub /\D/, ""
      conditions += "populated_place_id = " + sit
    end
    (conditions = " WHERE " + conditions)unless conditions.blank?
    paginate_by_sql("SELECT showplaces.* FROM showplaces" + conditions, :page => page, :per_page => items_per_page)
  end

end
