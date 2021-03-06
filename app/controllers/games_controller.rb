class GamesController < ApplicationController
  def index
    if user_signed_in?
      @games_pending = Game.all.where(status: "pending").order("created_at DESC")
      @games_started = Game.all.where(status: "started").order("created_at DESC")
    else
      redirect_to new_user_session_path
    end
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
      @game.red = 9
      @game.blue = 8
      @game.turn = "red"
    else
      @game.red = 8
      @game.blue = 9
      @game.turn = "blue"
    end
    @game.save
    # user is also participating
    GameTeam.create(game: @game, user: current_user, validated: true)

    # generation of words
    @array_of_words = Word.all.sample(25)
    final_array = []
    @array_of_words[0..@game.red - 1].each do |word|
      final_array << { word_id: word.id, game_id: @game.id, color: "red", discovered: false }
    end
    @array_of_words[@game.red..(@game.red + @game.blue - 1)].each do |word|
      final_array << { word_id: word.id, game_id: @game.id, color: "blue", discovered: false }
    end
    @array_of_words[(@game.red + @game.blue)..-2].each do |word|
      final_array << { word_id: word.id, game_id: @game.id, color: "white", discovered: false }
    end
    final_array << { word_id: @array_of_words.last.id, game_id: @game.id, color: "black", discovered: false }

    final_array.shuffle.each_with_index do|word_to_create, i|
      word_to_create[:order] = i + 1
      WordGame.create(word_to_create)
    end
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
    elsif params["format"] == "leave"
      new_turn = @game.turn == "red" ? "blue" : "red"
      @game.update(turn: new_turn)
    end
    redirect_to game_path(@game)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.game_teams.each { |player| player.destroy }
    @game.word_games.each { |word| word.destroy }
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
