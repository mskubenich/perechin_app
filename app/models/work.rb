class Work < ActiveRecord::Base
  belongs_to :author, :class_name => "User" , :foreign_key => "user_id"
  belongs_to :art_subcategory
  attr_accessible :art_subcategory_id, :body, :title, :author, :user_id, :moderate
  validates :title, :presence => true
  validates :body, :presence => true
  validates :art_subcategory_id, :presence => true

  def self.search(page = 1, art_category_id, art_subcategory_id, author_id)
    items_per_page = 10

    conditions = ""
    join = ""
    unless art_subcategory_id.blank?
      art_subcategory_id = art_subcategory_id.gsub /\D/, ""
      conditions += "art_subcategory_id = " + art_subcategory_id
    end
    unless author_id.blank?
      conditions += " AND " if conditions != ""
      author_id = author_id.gsub /\D/, ""
      conditions += "user_id = " + author_id
    end
    unless art_category_id.blank?
      conditions += " AND " if conditions != ""
      art_category_id = art_category_id.gsub /\D/, ""
      join = "LEFT JOIN art_subcategories ON art_subcategories.id = works.art_subcategory_id"
      conditions += "art_subcategories.art_category_id = " + art_category_id
    end
    (conditions = " WHERE " + conditions)unless conditions.blank?
    paginate_by_sql("SELECT works.* FROM works " + join + " " + conditions, :page => page, :per_page => items_per_page)
  end
end
