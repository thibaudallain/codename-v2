class WordGamesController < ApplicationController
  def update
    @word_game = WordGame.find(params[:id])
    @game = Game.find(params[:game_id])
    @word_game.update(discovered: true)
    new_turn = @game.turn == "red" ? "blue" : "red"
    @game.update(turn: new_turn) if @game.turn != @word_game.color
    redirect_to game_path(@game)
  end
end
