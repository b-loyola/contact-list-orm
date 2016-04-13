class Connection

	def self.connect()
    @@conn = PG::Connection.new(host: 'localhost', dbname: 'contactlist', user: 'development', password: 'development')
  end
	
	def conn
		@@conn
	end

end