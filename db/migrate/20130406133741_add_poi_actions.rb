class AddPoiActions < ActiveRecord::Migration
  def change
    admin = Role.find_by_name "admin"
    guest = Role.find_by_name "guest"
    user = Role.find_by_name "user"
    author = Role.find_by_name "author"

    actions = []
    actions << Action.create(:controller => "maps", :action => "showplace" , :method => :get)
    actions.each do |action|
      ControllerRolePermission.create :role_id => admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => guest.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => user.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => author.id, :action_id => action.id, :has_access => true
    end

    actions = []
    actions << Action.create(:controller => "maps", :action => "new_showplace" , :method => :get)
    actions << Action.create(:controller => "maps", :action => "create_showplace" , :method => :post)
    actions << Action.create(:controller => "maps", :action => "edit_showplace" , :method => :get)
    actions << Action.create(:controller => "maps", :action => "update_showplace" , :method => :post)
    actions << Action.create(:controller => "maps", :action => "destroy_showplace" , :method => :post)
    actions.each do |action|
      ControllerRolePermission.create :role_id => admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => user.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => author.id, :action_id => action.id, :has_access => false
    end
  end
end
