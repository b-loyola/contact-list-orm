require 'pg'

class Contact

  attr_accessor :name, :email, :id
  
  def initialize(name, email, id = nil)
    @name = name
    @email = email
    @id = id
  end

  # Inserts contact into database and returns Contact object instance of updated contact 
  def save
    if id
      Connection.conn.exec_params('UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int;', [name,email,id])
    else
      pg_contact = Connection.conn.exec_params('INSERT INTO contacts (name,email) VALUES ($1, $2) RETURNING *;', [name,email])
      self.id = pg_contact[0]["id"]
    end
    self
  end

  def destroy
    Connection.conn.exec_params('DELETE FROM contacts WHERE id=$1::int;', [id])
  end

  def self.connect
    Connection.conn = PG::Connection.new(host: 'localhost', dbname: 'contactlist', user: 'development', password: 'development')
  end

  def self.all
    # Returns an Array of Contact instances made from the data in database.
    Connection.conn.exec('SELECT * FROM contacts ORDER BY id;').inject([]) do |list, contact|
      contact = Contact.new(contact["name"], contact["email"], contact["id"])
      list << contact
    end
  end

  def self.create(name, email)
    # Instantiate a Contact, add its data to the database, and return it.
    return nil unless search(email).empty?
    Contact.new(name, email).save
    
  end
  
  def self.find(id)
    # Find the Contact in the database with the matching id.
    contact = Connection.conn.exec_params('SELECT * FROM contacts WHERE id=$1::int;', [id])
    contact.ntuples > 0 ? Contact.new(contact[0]["name"],contact[0]["email"],contact[0]["id"]) : nil
  end
  
  # Search for contacts by either name or email.
  def self.search(term)
    # Searches the database for matches and returns an array of Contact object instances.
    Connection.conn.exec_params('SELECT * FROM contacts WHERE name ILIKE $1 OR email ILIKE $1;', ['%'+term+'%']).inject([]) do |matches,contact|
      contact = Contact.new(contact["name"], contact["email"], contact["id"])
      matches << contact
    end
  end

end