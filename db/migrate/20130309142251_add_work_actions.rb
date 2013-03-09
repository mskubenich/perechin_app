class AddWorkActions < ActiveRecord::Migration
  def up
    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"
    @author = Role.find_by_name "author"

    actions = []
    actions << Action.create(:controller => "arts", :action => :create, :method => :post)
    actions << Action.create(:controller => "arts", :action => :new, :method => :get)
    actions << Action.create(:controller => "arts", :action => :edit, :method => :get)
    actions << Action.create(:controller => "arts", :action => :update, :method => :post)
    actions << Action.create(:controller => "arts", :action => :destroy, :method => :post)

    actions.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @author.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
    end

    actions = [Action.create(:controller => "arts", :action => :show, :method => :get)]

    actions.each do |action|
      ControllerRolePermission.create :role_id => @author.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
    end
  end

  def down
  end
end
