class AddValidatedToGameTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :game_teams, :validated, :boolean
  end
end
