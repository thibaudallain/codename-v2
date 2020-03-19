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

    # generation of words

    @array_of_words = Word.all.shuffle.first(25)
    @array_of_words[0..@game.red - 1].each do |word|
      WordGame.create!(word_id: word.id, game_id: @game.id, color: "red", discovered: false)
    end
    @array_of_words[@game.red..(@game.red + @game.blue - 1)].each do |word|
      WordGame.create!(word_id: word.id, game_id: @game.id, color: "blue", discovered: false)
    end
    @array_of_words[(@game.red + @game.blue)..-2].each do |word|
      WordGame.create!(word_id: word.id, game_id: @game.id, color: "white", discovered: false)
    end
    WordGame.create!(word_id: @array_of_words.last.id, game_id: @game.id, color: "black", discovered: false)
    @list_of_words = WordGame.where(game_id: @game.id)
    @list_of_words = @list_of_words.shuffle

    redirect_to games_path
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if params["format"] == "start"
      @game.update(status: "started")
      shuffled_players = @game.game_teams.shuffle
      shuffled_players[0..shuffled_players.length / 2 - 1].each { |player| player.update(team: "blue") }
      shuffled_players[shuffled_players.length / 2..-1].each { |player| player.update(team: "red") }
      @game.game_teams.where(team: "blue").first.update(spy: true)
      @game.game_teams.where(team: "red").first.update(spy: true)
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
