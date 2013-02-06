class AddViewCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :view_count, :integer

    sql = ActiveRecord::Base.connection()
    sql.execute("UPDATE articles SET view_count = 0")
  end
end
