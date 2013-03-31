class CreatePopulatedPlaces < ActiveRecord::Migration
  def change
    create_table :populated_places do |t|
      t.string :title
      t.text :description
    end
  end
  add_column :attached_assets, :populated_place_id, :integer
end
