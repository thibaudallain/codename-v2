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
    @game.status = "pending"
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
    GameTeam.create(game: @game, user: current_user, validated: true)

    redirect_to games_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if params["format"] == "start"
      @game.update(status: "started")
    elsif params["format"] == "end"
      @game.update(status: "over")
    end
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
