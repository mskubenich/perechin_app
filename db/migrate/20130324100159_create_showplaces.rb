class CreateShowplaces < ActiveRecord::Migration
  def change
    create_table :showplaces do |t|
      t.string :name
      t.float :latitude #you can change the name, see wiki
      t.float :longitude #you can change the name, see wiki
      t.boolean :gmaps #not mandatory, see wiki
    end
  end
end
