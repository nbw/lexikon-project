require 'rubygems'
require 'pg'

require 'lib/Db'

puts "Clean TABLE: " + Db::TNAME + " or DATABASE: " + Db::DBNAME + "?"
resp = gets.chomp

if(resp.upcase == "TABLE")
	puts "Deleting TABLE: " + Db::TNAME + ".."

	Db.connect
	Db.query('DROP TABLE ' + Db::TNAME)

elsif (resp.upcase == "DATABASE")
	puts "Deleting DATABASE: " + Db::DBNAME + ".."

	Db.connect
	Db.query('DROP DATABASE ' + Db::DBNAME)

else
	puts "Aborted"
end

