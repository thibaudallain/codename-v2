# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

require 'csv'

Word.destroy_all

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath = "db/words.csv"

CSV.foreach(filepath, csv_options) do |row|
  Word.create(word: row[0])
end

User.create( email: 't@code.com', password: "abc123" )
User.create( email: 'a@code.com', password: "abc123" )
User.create( email: 'b@code.com', password: "abc123" )
User.create( email: 'c@code.com', password: "abc123" )
