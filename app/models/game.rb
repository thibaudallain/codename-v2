class Game < ApplicationRecord
  has_many :word_games, dependent: :destroy
  has_many :words, through: :word_games
  has_many :game_teams
  has_many :users, through: :game_teams
  belongs_to :user

  validates :name, presence: true

  after_update :broadcast_message, if: :started?

  def broadcast_message
    ActionCable.server.broadcast("game_#{id}", {
      seeker_not_player: ApplicationController.renderer.render(
        partial: "games/grid_seeker_not_player",
        locals: { game: self }
      ),
      seeker_player: ApplicationController.renderer.render(
        partial: "games/grid_seeker_player",
        locals: { game: self }
      ),
      spy: ApplicationController.renderer.render(
        partial: "games/grid_spy",
        locals: { game: self }
      ),
      list: ApplicationController.renderer.render(
        partial: "games/list",
        locals: { game: self }
      )
   })
  end

  def started?
    status == "started"
  end
end
