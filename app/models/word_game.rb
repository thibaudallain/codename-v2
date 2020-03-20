class WordGame < ApplicationRecord
  belongs_to :game
  belongs_to :word

  validates :word, uniqueness: { scope: :game }

  after_update :broadcast_message

  def broadcast_message
    ActionCable.server.broadcast("game_#{game.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "word_games/word_grid",
        locals: { word: self.word, game: self.game }
      )
    })
  end
end
