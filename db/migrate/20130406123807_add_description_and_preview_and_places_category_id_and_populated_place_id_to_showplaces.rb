class AddDescriptionAndPreviewAndPlacesCategoryIdAndPopulatedPlaceIdToShowplaces < ActiveRecord::Migration
  def change
    add_column :showplaces, :places_category_id, :integer
    add_column :showplaces, :populated_place_id, :integer
    add_column :showplaces, :description, :text
    add_column :showplaces, :preview, :text
  end
end
