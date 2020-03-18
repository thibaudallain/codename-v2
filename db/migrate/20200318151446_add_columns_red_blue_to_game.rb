class AddColumnsRedBlueToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :red, :integer
    add_column :games, :blue, :integer
  end
end
