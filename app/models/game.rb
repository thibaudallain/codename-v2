class Game < ApplicationRecord
  has_many :word_games, dependent: :destroy
  has_many :words, through: :word_games
  has_many :game_teams
  has_many :users, through: :game_teams
  belongs_to :user

  validates :name, presence: true
end
