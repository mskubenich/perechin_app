class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
        t.string :title
        t.text :body, :limit => 64.kilobytes
        t.integer :user_id
        t.string :source
        t.text :preview
        t.timestamps
    end

      add_column :attached_assets, :article_id, :integer
      add_column :users, :article_id, :integer
      add_column :comments, :article_id, :integer

      @admin = Role.find_by_name "admin"
      @guest = Role.find_by_name "guest"
      @user = Role.find_by_name "user"

      actions = []
      actions << Action.create(:controller => "articles", :action => :index , :method => :get)
      actions << Action.create(:controller => "articles", :action => :show, :method => :get)

      actions.each do |action|
        ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
        ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => true
        ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
      end

      actions = []
      actions << Action.create(:controller => "articles", :action => :create_comment , :method => :post)

      actions.each do |action|
        ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
        ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
        ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => true
      end

      actions =[]
      actions << Action.create(:controller => "articles", :action => :destroy , :method => :post)
      actions << Action.create(:controller => "articles", :action => :edit , :method => :get)
      actions << Action.create(:controller => "articles", :action => :update , :method => :post)
      actions << Action.create(:controller => "articles", :action => :new , :method => :get)
      actions << Action.create(:controller => "articles", :action => :create , :method => :post)
      actions << Action.create(:controller => "admin/tags", :action => :tags_for_autocomplete , :method => :get)

      actions.each do |action|
        ControllerRolePermission.create :role_id => @admin.id, :action_id => action.id, :has_access => true
        ControllerRolePermission.create :role_id => @guest.id, :action_id => action.id, :has_access => false
        ControllerRolePermission.create :role_id => @user.id, :action_id => action.id, :has_access => false
      end

  end
end
