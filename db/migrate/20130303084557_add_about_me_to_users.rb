class AddAboutMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about_me, :text
    remove_column :art_categories, :created_at
    remove_column :art_categories, :updated_at
  end
end
