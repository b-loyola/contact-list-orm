class ContactList

	attr_accessor :contacts

  def list_all
  	list(Contact.all)
	end

	def list(contacts_to_list)
		contacts_to_list.each_with_index do |contact,index|
			if index % 5 == 4
				puts "#{contact.id}: #{contact.name} (#{contact.email})"
				print "*** Press enter to continue... ***"
				STDIN.gets
			else
				puts "#{contact.id}: #{contact.name} (#{contact.email})"
			end
		end
		puts "---"
		puts "#{contacts_to_list.size} contacts total"
	end

	def create_new
		puts "Enter full name:"
		name = STDIN.gets.chomp
		puts "Enter email address:"
		email = STDIN.gets.chomp
		contact = Contact.create(name, email)
		if contact
			puts "Contact #{contact.name} created successfully with id #{contact.id}!"
		else
			puts "Unable to create contact, please ensure email is unique."
		end
	end

	def show_contact(id)
		unless id =~ /^\d+$/
			puts "Contact ID must be a number!"
			return
		end
		contact = Contact.find(id.to_i)
		if contact
			puts contact
		else
			puts "Contact not found!"
		end
	end

	def search_contact(term)
		found_contacts = Contact.search(term)
		if found_contacts
			list(found_contacts)
		else
			puts "No contacts matched your search criteria!"
		end

	end

end