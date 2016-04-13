class Phone

	attr_reader :contact_id, :type, :number

	def initialize(contact_id, type, number)
		@contact_id = contact_id
		@type = type
		@number = number
	end

	def save
    Connection.conn.exec_params('INSERT INTO phones (contact_id,type,number) VALUES ($1, $2, $3) RETURNING *;', [contact_id, type, number])  
  end

end