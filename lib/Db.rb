require 'rubygems'
require 'lib/serverconfig'
module Db



	@connection = nil

	def self.connect
		# PG::Connection.new(host, port, options, tty, dbname, user, password) → conn
		@connection = PG::Connection.new( HOST, PORT, nil, nil, DBNAME, nil, nil )
	end

	def self.query(msg)
		begin
		    @connection.exec(msg)
		rescue PG::Error => err
    	p [
	        err.result.error_field( PG::Result::PG_DIAG_SEVERITY ),
	        err.result.error_field( PG::Result::PG_DIAG_SQLSTATE ),
	        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_PRIMARY ),
	        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_DETAIL ),
	        err.result.error_field( PG::Result::PG_DIAG_MESSAGE_HINT ),
	        err.result.error_field( PG::Result::PG_DIAG_STATEMENT_POSITION ),
	        err.result.error_field( PG::Result::PG_DIAG_INTERNAL_POSITION ),
	        err.result.error_field( PG::Result::PG_DIAG_INTERNAL_QUERY ),
	        err.result.error_field( PG::Result::PG_DIAG_CONTEXT ),
	        err.result.error_field( PG::Result::PG_DIAG_SOURCE_FILE ),
	        err.result.error_field( PG::Result::PG_DIAG_SOURCE_LINE ),
	        err.result.error_field( PG::Result::PG_DIAG_SOURCE_FUNCTION ),
	    ]
		end
	end

	def self.escape(string)
		return PG::Connection.escape_string(string)
	end

end