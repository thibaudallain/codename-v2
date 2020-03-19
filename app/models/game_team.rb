class GameTeam < ApplicationRecord
  belongs_to :game
  belongs_to :user
  validates :user, uniqueness: { scope: :game }
end
