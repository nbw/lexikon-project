require 'rubygems'
require 'liquid'
require 'pg'
require 'sinatra'
require "sinatra/reloader" 

require 'lib/Db'

Sinatra::Base.set(:public_folder, 'static')
Sinatra::Base.set(:views, 'templates')


get '/' do

	Db.connect
	liquid(:index, :locals => { :dictionary => get_words })
  	# return File.read("#{File.dirname(__FILE__)}/static/index.html")

end

def get_words()

	puts "MARKER"

	res = Db.query("SELECT word, definition, author, date FROM dict WHERE active = TRUE ORDER BY word;")
	letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
	dictionary = []
	i=0

	letters.each do |letter|
		arr = []
		# IF THERE ARE WORDS LEFT
		if i != (res.ntuples)
			# WHILE THE CURRENT LETTER EQUALS THE FIRST LETTER OF THE SELECTED WORD
			while letter == res[i]['word'][0].chr
					arr << {"word" => res[i]['word'],
							"definition" => res[i]['definition'],
							"author" => res[i]['author'], 
							"timestamp" => res[i]['date']} 
					i += 1
					break if i == (res.ntuples)
			end
		end
		dictionary << {"letter" => letter, "words" => arr} 
	end
	return dictionary
end

################
# ADMIN ACCESS
################

post '/api/addword' do
	word =  Db::escape(params[:word].capitalize)
	author = Db::escape(params[:author])
	panelbody = Db::escape(params[:panelbody])
	timestamp = Db::escape(params[:timestamp])
	puts params.inspect

	Db.connect
	Db.query("INSERT INTO "+Db::TNAME+" VALUES('" +word+ "','" +panelbody+ "','" +author+"',now(),TRUE)")
end

def authorized?
@auth ||=  Rack::Auth::Basic::Request.new(request.env)
@auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ["chicken","soup"]
end

def protected!
unless authorized?
  response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
  throw(:halt, [401, "Oops... we need your login name & password\n"])
end
end

get "/admin" do
protected!
	Db.connect
  	return File.read("#{File.dirname(__FILE__)}/admin/index.html")
end