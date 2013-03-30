class CreateAnecdotes < ActiveRecord::Migration
  def change
    create_table :anecdotes do |t|
      t.string :title
      t.text :body

      t.timestamps
    end

    add_column :attached_assets, :anecdote_id, :integer
  end
end
