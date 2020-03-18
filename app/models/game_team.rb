class GameTeam < ApplicationRecord
  belongs_to :Game
  belongs_to :User
end
