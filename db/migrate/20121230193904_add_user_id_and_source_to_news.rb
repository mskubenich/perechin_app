class AddUserIdAndSourceToNews < ActiveRecord::Migration
  def change
    add_column :news, :user_id, :integer
    add_column :news, :source, :string
  end
end
