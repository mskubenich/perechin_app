class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.string :controller
      t.string :action
      t.string :method
    end

    Action.create :controller => "admin/roles", :action => :index, :method => :get
    Action.create :controller => "admin/roles", :action => :show, :method => :get
    Action.create :controller => "admin/roles", :action => :new, :method => :get
    Action.create :controller => "admin/roles", :action => :create, :method => :post
    Action.create :controller => "admin/roles", :action => :edit, :method => :get
    Action.create :controller => "admin/roles", :action => :update, :method => :put
    Action.create :controller => "admin/roles", :action => :destroy, :method => :delete

    Action.create :controller => "news", :action => :new, :method => :get
    Action.create :controller => "news", :action => :create, :method => :post

    Action.create :controller => "pages", :action => :home, :method => :get
    Action.create :controller => "pages", :action => :contact, :method => :get
    Action.create :controller => "pages", :action => :about, :method => :get
    Action.create :controller => "pages", :action => :help, :method => :get

    Action.create :controller => "sessions", :action => :new, :method => :get
    Action.create :controller => "sessions", :action => :create, :method => :post
    Action.create :controller => "sessions", :action => :destroy, :method => :post

    Action.create :controller => "users", :action => :new, :method => :get
    Action.create :controller => "users", :action => :show, :method => :get
    Action.create :controller => "users", :action => :create, :method => :post

    @admin = Role.create :name => "admin", :description => "admin have all permissions"
    @guest = Role.create :name => "guest", :description => "guest role"
    @user = Role.create :name => "user", :description => "logged user role"

    Action.all.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      if action.controller == "users"
        if action.action == "create" || action.action == "new"
          ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
          ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
        else
          ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
          ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
        end
      elsif action.controller == "admin/roles"
        ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
        ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
      elsif action.controller == "news"
        if action.action == "index" || action.action == "show"
          ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
          ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
        else
          ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
          ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
        end
      else
        ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
        ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
      end
    end

  end

  def self.down
    drop_table :actions
  end
end
