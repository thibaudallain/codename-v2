class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    # game creation
    @game = Game.new(game_params)
    @game.status = "Pending"
    @game.user = current_user
    if rand(0..10) <= 5
      @game.red = 8
      @game.blue = 7
    else
      @game.red = 7
      @game.blue = 8
    end
    @game.save

    # user is also participating
    GameTeam.create(game: @game, user: current_user)

    redirect_to games_path
  end

  def show
    @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
