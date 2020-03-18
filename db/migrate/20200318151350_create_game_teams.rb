class CreateGameTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :game_teams do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :spy
      t.string :team

      t.timestamps
    end
  end
end
