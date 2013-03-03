class AddUserEditActions < ActiveRecord::Migration
  def change
    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"

    actions = []
    actions << Action.create(:controller => "users", :action => :edit , :method => :get)
    actions << Action.create(:controller => "users", :action => :change_name , :method => :post)
    actions << Action.create(:controller => "users", :action => :change_password , :method => :post)
    actions << Action.create(:controller => "users", :action => :change_avatar , :method => :post)
    actions << Action.create(:controller => "users", :action => :change_about_me , :method => :post)

    actions.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
    end
  end
end
