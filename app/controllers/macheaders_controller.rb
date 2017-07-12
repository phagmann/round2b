class MacheadersController < ApplicationController
    require 'sqlite3'
    protect_from_forgery with: :null_session
    def index
         #!/usr/bin/ruby
         @db = SQLite3::Database.new 'db/data.db'
         # min [1498431718]
         # max [1498436287]
         mac = Mac.first
         ts1 = mac.start_time + 1498431718
         ts2 = mac.end_time + 1498431718
         array_of_data = []
         @db.execute 'SELECT mac_headers.type,mac_headers.subtype, COUNT(mac_headers.subtype) FROM mac_headers WHERE mac_headers.timestamp  BETWEEN ? and ? GROUP BY mac_headers.type, mac_headers.subtype', ts1, ts2 do |row|
            array_of_data += [row]
         end
         p array_of_data.length
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
    def show
        render json: Mac.first
    end

    def update
        m = Mac.find(params[:id])
        m.update_attributes(mac_params)
        m.save
        render json: m
    end

    private

    def mac_params
      params.require(:mac).permit(:start_time, :end_time)
    end
end
