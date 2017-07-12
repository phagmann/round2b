class MacheadersController < ApplicationController
    require 'sqlite3'

    def index

         #!/usr/bin/ruby
         @db = SQLite3::Database.new 'db/data.db'
         ts1 = 1498436187
         ts2 = 1498436287
         array_of_data = []
         @db.execute 'SELECT mac_headers.type,mac_headers.subtype, COUNT(mac_headers.subtype) FROM mac_headers WHERE mac_headers.timestamp  BETWEEN ? and ? GROUP BY mac_headers.timestamp, mac_headers.type, mac_headers.subtype', ts1, ts2 do |row|
            array_of_data += [row]
         end
         hash_organize = Hash.new
         array_of_data.each do |array|
            if hash_organize.include?(array[1])
                hash_organize[array[1]] += [[array[0],array[2]]]
            else
                hash_organize[array[1]] = [[array[0],array[2]]]
            end
         end

         @data =[]
         hash_organize.keys.each do |type|
            @data += [{
                name: type.to_s,
                data: hash_organize[type]
            }]

         end



    end
end
