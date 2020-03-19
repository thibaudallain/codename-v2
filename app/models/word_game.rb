class WordGame < ApplicationRecord
  belongs_to :game
  belongs_to :word

  validates :word, uniqueness: { scope: :game }
end
