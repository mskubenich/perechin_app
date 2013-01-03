class CreateJoinConfirmations < ActiveRecord::Migration
  def change
    create_table :join_confirmations do |t|
      t.integer :user_id
      t.string :activation_code

      t.timestamps
    end

    @action = Action.create :controller => "sessions", :action => :join_confirm , :method => :get

    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"


    ControllerRolePermission.create :role_id => @admin.id, :action_id => @action.id, :has_access => true
    ControllerRolePermission.create :role_id => @guest.id, :action_id => @action.id, :has_access => true
    ControllerRolePermission.create :role_id => @user.id, :action_id => @action.id, :has_access => true


  end
end
