class Role < ActiveRecord::Base
  has_many :users
  has_many :controller_role_permissions, :dependent => :destroy

  attr_accessible :description, :name

  validates :name, :presence => true,
                   :uniqueness => true
  validates :description, :presence => true
end
