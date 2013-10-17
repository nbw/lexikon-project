require 'rubygems'
require 'pg'

require Dir.pwd+'/lib/Db'

Db.connect
#Use the right DB
# Db.query('\connect ' + Db::DBNAME)
#Table creation
Db.query('
	CREATE TABLE ' + TNAME + ' (
    word varchar(255),
    definition varchar(512),
    author varchar(255),
    date timestamp,
    active boolean
)')

