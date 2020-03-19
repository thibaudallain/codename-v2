class Word < ApplicationRecord
  has_many :word_games, dependent: :destroy
  has_many :games, through: :word_games
  validates :word, presence: true
end
