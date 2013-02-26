class CreateArtCategories < ActiveRecord::Migration
  def change
    create_table :art_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
