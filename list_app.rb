#!/usr/bin/env ruby

require_relative 'lib/contact'
require_relative 'lib/contact_list'
require_relative 'lib/phone'
require_relative 'lib/connection'


command = String.new
option = String.new

Connection.connect

if ARGV.empty?
	puts "Here is a list of available commands:"
	puts "\tnew             - Create a new contact"
	puts "\tlist            - List all contacts"
	puts "\tshow 'id'       - Show a contact"
	puts "\tsearch 'term'   - Search contacts"
	puts "\tupdate 'id'     - update contact"
	puts "\tdelete 'id'     - delete contact"
	puts "\taddphone 'id'   - add phone number"
	puts "\tphones 'id'     - list phone numbers (enter * as id for all numbers)"
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
when "addphone"
	ContactList.new.add_phone(option)
when 'phones'
	option == '*' ? ContactList.new.all_phones : ContactList.new.find_phones(option)	
else
	puts "Invalid command"
end