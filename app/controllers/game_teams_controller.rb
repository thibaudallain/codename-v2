class GameTeamsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @new_player = GameTeam.create(game: @game, user: current_user, validated: false)
    redirect_to game_path(@game)
  end
end
