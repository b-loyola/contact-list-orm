#!/usr/bin/env ruby

require_relative 'lib/contact'
require_relative 'lib/contact_list'
require_relative 'lib/phone'


command = String.new
option = String.new

Contact.connect
Phone.connect

if ARGV.empty?
	puts "Here is a list of available commands:"
	puts "\tnew             - Create a new contact"
	puts "\tlist            - List all contacts"
	puts "\tshow 'id'       - Show a contact"
	puts "\tsearch 'term'   - Search contacts"
	puts "\tupdate 'id'     - update contact"
	puts "\tdelete 'id'     - delete contact"
	puts "\tphone 'id'      - add phone number"
	puts "\tlistphones 'id' - add phone number"
	command, option = gets.chomp.split(' ')
else
	command = ARGV[0]
	option = ARGV[1]
end

case command
when "list"
	ContactList.new.list_all
when "new"
	ContactList.new.create_new
when "show"
	ContactList.new.show_contact(option)
when "search"
	ContactList.new.search_contact(option)
when "update"
	ContactList.new.update_contact(option)
when "delete"
	ContactList.new.delete_contact(option)
when "phone"
	ContactList.new.add_phone(option)
else
	puts "Invalid command"
end