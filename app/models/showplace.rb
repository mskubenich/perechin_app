class Showplace < ActiveRecord::Base
  acts_as_gmappable :process_geocoding => false
  attr_accessible :name

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
   # "#{self.street}, #{self.city}, #{self.country}"
    "just desc"
  end


  def gmaps4rails_infowindow
    "<h4>#{name}</h4>"
  end
end
