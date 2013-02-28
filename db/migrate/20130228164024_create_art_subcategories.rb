class CreateArtSubcategories < ActiveRecord::Migration
  def change
    create_table :art_subcategories do |t|
      t.string :title
      t.integer :category_id
      t.boolean :is_moderated
    end
  end
end
