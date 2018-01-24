class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches, {:id => false} do |t|
	  t.integer :id
      t.integer :game_id
      t.integer :winner_team_id

      t.timestamps null: false
    end
    execute "ALTER TABLE matches ADD PRIMARY KEY (id,game_id);"
  end
end
