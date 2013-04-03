class CreatePlacesCategories < ActiveRecord::Migration
  def change
    create_table :places_categories do |t|
      t.string :name
    end
  end
end
