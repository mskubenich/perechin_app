class AddPreviewToNews < ActiveRecord::Migration
  def change
    add_column :news, :preview, :text
  end
end
