class AddColumnWonToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :won, :string
  end
end
