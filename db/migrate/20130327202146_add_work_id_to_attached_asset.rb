class AddWorkIdToAttachedAsset < ActiveRecord::Migration
  def change
    add_column :attached_assets, :work_id, :integer
  end
end
