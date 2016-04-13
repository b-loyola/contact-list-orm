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

  def self.all
    # Returns an Array of Phone instances made from the data in database.
    Connection.conn.exec('SELECT * FROM phones ORDER BY id;').inject([]) do |list, contact|
      list << Phone.new(phone["contact_id"], phone["type"], phone["number"])
    end
  end

  def self.find(id)
    # Find the all the Phones in the database for the id provided.
    Connection.conn.exec_params('SELECT * FROM phones WHERE contact_id=$1::int;', [id]).inject([]) do |list, phone|
    	list << Phone.new(phone["contact_id"], phone["type"], phone["number"])
    end
  end

end