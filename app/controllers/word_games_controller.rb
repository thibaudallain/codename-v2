class WordGamesController < ApplicationController
  def update
    @word_game = WordGame.find(params[:id])
    @game = Game.find(params[:game_id])
    @word_game.update(discovered: true)
    new_turn = @game.turn == "red" ? "blue" : "red"
    @game.update(won: new_turn, status: "over") if @word_game.color == "black"
    @game.update(turn: new_turn) if @game.turn != @word_game.color
    if WordGame.where(game: @game, discovered: false, color: "red").length == 0
      @game.update(won: "red", status: "over")
    elsif WordGame.where(game: @game, discovered: false, color: "blue").length == 0
      @game.update(won: "red", status: "over")
    end
    redirect_to game_path(@game)
  end
end
