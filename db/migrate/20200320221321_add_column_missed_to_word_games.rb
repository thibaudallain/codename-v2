class AddColumnMissedToWordGames < ActiveRecord::Migration[5.2]
  def change
    add_column :word_games, :missed, :boolean
  end
end
