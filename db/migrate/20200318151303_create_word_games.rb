class CreateWordGames < ActiveRecord::Migration[5.2]
  def change
    create_table :word_games do |t|
      t.references :game, foreign_key: true
      t.references :word, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
