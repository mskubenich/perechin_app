class Action < ActiveRecord::Base
  has_many :controller_role_permissions
  attr_accessible :action, :controller, :method
end
