class AddUserListAction < ActiveRecord::Migration
  def change
    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"

    actions = []
    actions << Action.create(:controller => "admin/users", :action => :index , :method => :get)

    actions.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
    end
  end
end
