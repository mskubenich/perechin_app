class CreateControllerRolePermissions < ActiveRecord::Migration
  def change
    create_table :controller_role_permissions do |t|
      t.integer :role_id
      t.integer :action_id
      t.boolean :has_access
    end
  end
end
