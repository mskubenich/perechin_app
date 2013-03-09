class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :title
      t.text :body
      t.integer :art_subcategory_id
      t.integer :user_id

      t.timestamps
    end
  end
end
