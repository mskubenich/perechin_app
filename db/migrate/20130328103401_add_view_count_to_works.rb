class AddViewCountToWorks < ActiveRecord::Migration
  def change
    add_column :works, :view_count, :integer
    Work.all.each do |work|
      work.update_attribute(:view_count, 0)
    end
  end
end
