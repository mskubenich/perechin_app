class CreateAttachedAssets < ActiveRecord::Migration
  def change
    create_table :attached_assets do |t|
      t.has_attached_file :asset
      t.integer :news_id
    end
  end
end
