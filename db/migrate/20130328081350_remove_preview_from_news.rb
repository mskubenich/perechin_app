class RemovePreviewFromNews < ActiveRecord::Migration
  def up
    remove_column :news, :preview
    remove_column :articles, :preview
  end

  def down
    add_column :news, :preview, :text
    add_column :articles, :preview, :text
  end
end
