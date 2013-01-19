class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :title

      t.timestamps
    end

    actions = []
    actions << Action.create(:controller => "admin/tags", :action => :index , :method => :get)
    actions << Action.create(:controller => "admin/tags", :action => :new , :method => :get)
    actions << Action.create(:controller => "admin/tags", :action => :create , :method => :post)
    actions << Action.create(:controller => "admin/tags", :action => :edit , :method => :get)
    actions << Action.create(:controller => "admin/tags", :action => :update , :method => :post)
    actions << Action.create(:controller => "admin/tags", :action => :destroy , :method => :post)

    admin = Role.find_by_name "admin"
    guest = Role.find_by_name "guest"
    user = Role.find_by_name "user"

    actions.each do |action|
      ControllerRolePermission.create :role_id => admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => user.id, :action_id => action.id, :has_access => false
    end

  end
end
