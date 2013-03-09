class CreateRoleAuthor < ActiveRecord::Migration
  def change
    author = Role.create :name => "author", :description => "can create art"
    user = Role.find_by_name "user"
    user.controller_role_permissions.each do |permission|
      ControllerRolePermission.create :role_id => author.id, :action_id => permission.action_id, :has_access => permission.has_access
    end
  end
end
