class AddViewCountToNews < ActiveRecord::Migration
  def change
    add_column :news, :view_count, :integer

    sql = ActiveRecord::Base.connection()
    sql.execute("UPDATE news SET view_count = 0")
  end
end
