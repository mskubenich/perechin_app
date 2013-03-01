class AddArtSubcategoryActions < ActiveRecord::Migration
  def up

    @admin = Role.find_by_name "admin"
    @guest = Role.find_by_name "guest"
    @user = Role.find_by_name "user"

    actions = []
    actions << Action.create(:controller => "admin/art_subcategories", :action => :index, :method => :get)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :create, :method => :post)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :new, :method => :get)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :edit, :method => :get)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :show, :method => :get)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :update, :method => :post)
    actions << Action.create(:controller => "admin/art_subcategories", :action => :destroy, :method => :post)

    actions.each do |action|
      ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
    end

  end

  def down
  end
end
