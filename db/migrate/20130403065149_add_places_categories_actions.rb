class AddPlacesCategoriesActions < ActiveRecord::Migration
  def change
    admin = Role.find_by_name "admin"
    guest = Role.find_by_name "guest"
    user = Role.find_by_name "user"
    author = Role.find_by_name "author"

    actions = []
    actions << Action.create(:controller => "admin/places_categories", :action => "index" , :method => :get)
    actions << Action.create(:controller => "admin/places_categories", :action => "new" , :method => :get)
    actions << Action.create(:controller => "admin/places_categories", :action => "create" , :method => :post)
    actions << Action.create(:controller => "admin/places_categories", :action => "edit" , :method => :get)
    actions << Action.create(:controller => "admin/places_categories", :action => "update" , :method => :post)
    actions << Action.create(:controller => "admin/places_categories", :action => "destroy" , :method => :post)
    actions.each do |action|
      ControllerRolePermission.create :role_id => admin.id, :action_id => action.id, :has_access => true
      ControllerRolePermission.create :role_id => guest.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => user.id, :action_id => action.id, :has_access => false
      ControllerRolePermission.create :role_id => author.id, :action_id => action.id, :has_access => false
    end
  end
end
