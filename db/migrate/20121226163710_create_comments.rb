class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :user_id
      t.integer :news_id

      t.timestamps
    end
    @action = Action.create :controller => "news", :action => :create_comment , :method => :post

    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"

    ControllerRolePermission.create :role_id => @admin.id, :action_id => @action.id, :has_access => true
    ControllerRolePermission.create :role_id => @guest.id, :action_id => @action.id, :has_access => false
    ControllerRolePermission.create :role_id => @user.id, :action_id => @action.id, :has_access => true

  end
end
