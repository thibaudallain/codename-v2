class WordGame < ApplicationRecord
  belongs_to :game
  belongs_to :word

  validates :word, uniqueness: { scope: :game }

  after_update :broadcast_message

  def broadcast_message
    ActionCable.server.broadcast("game_#{game.id}", {
      seeker_not_player: ApplicationController.renderer.render(
        partial: "games/grid_seeker_not_player",
        locals: { game: game }
      ),
      seeker_player: ApplicationController.renderer.render(
        partial: "games/grid_seeker_player",
        locals: { game: game }
      ),
      spy: ApplicationController.renderer.render(
        partial: "games/grid_spy",
        locals: { game: game }
      ),
      list: ApplicationController.renderer.render(
        partial: "games/list",
        locals: { game: game }
      ), word: self
   })
  end
end
