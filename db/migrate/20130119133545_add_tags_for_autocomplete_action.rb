class AddTagsForAutocompleteAction < ActiveRecord::Migration
  def change
    action = Action.create :controller => "admin/tags", :action => :tags_for_autocomplete , :method => :get

    admin = Role.find_by_name "admin"
    guest = Role.find_by_name "guest"
    user = Role.find_by_name "user"

    ControllerRolePermission.create :role_id => admin.id, :action_id => action.id, :has_access => true
    ControllerRolePermission.create :role_id => guest.id, :action_id => action.id, :has_access => true
    ControllerRolePermission.create :role_id => user.id, :action_id => action.id, :has_access => false

  end
end
