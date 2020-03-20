class AddOrderToWordGames < ActiveRecord::Migration[5.2]
  def change
    add_column :word_games, :order, :integer
  end
end
