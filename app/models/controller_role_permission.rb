class ControllerRolePermission < ActiveRecord::Base
  belongs_to :role
  belongs_to :action

  attr_accessible :role_id, :action_id, :has_access
end
