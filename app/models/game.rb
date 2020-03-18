class Game < ApplicationRecord
  has_many :word_games, dependent: :destroy
  has_many :words, through: :word_games
end
