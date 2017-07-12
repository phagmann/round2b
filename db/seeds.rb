# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'sqlite3'

# Open a SQLite 3 database file
db = SQLite3::Database.new 'db/data.db'

db.execute 'SELECT mac_headers.timestamp, mac_headers.type, mac_headers.subtype FROM mac_headers' do |row|
  p row
end
