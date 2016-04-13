class Connection

	def self.connect()
    @@conn = PG::Connection.new(host: 'localhost', dbname: 'contactlist', user: 'development', password: 'development')
  end
	
	def self.conn
		@@conn
	end

end