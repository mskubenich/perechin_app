class ChangeColumnBodyInNews < ActiveRecord::Migration
  def up
    change_column :news, :body, :text, :limit => 64.kilobytes
  end

  def down
    change_column :news, :body, :string
  end
end
