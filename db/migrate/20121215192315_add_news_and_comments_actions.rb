class AddNewsAndCommentsActions < ActiveRecord::Migration
  def up
    Action.create :controller => "news", :action => :show, :method => :get

    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"

    Action.all.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
    end

  end

  def down
  end
end
