class AddColumnToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :word_games, :discovered, :boolean
  end
end
