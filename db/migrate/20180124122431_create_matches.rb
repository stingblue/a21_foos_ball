class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
	  t.string :title
      t.timestamps null: false
    end
    # execute "ALTER TABLE matches ADD PRIMARY KEY (id,game_id);"
  end
end
