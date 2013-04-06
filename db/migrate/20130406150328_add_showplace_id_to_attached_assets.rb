class AddShowplaceIdToAttachedAssets < ActiveRecord::Migration
  def change
    add_column :attached_assets, :showplace_id, :integer
  end
end
