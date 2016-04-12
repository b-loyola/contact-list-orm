#!/usr/bin/env ruby

require_relative 'lib/contact'
require_relative 'lib/contact_list'


command = String.new
option = String.new

Contact.connect

if ARGV.empty?
	puts "Here is a list of available commands:"
	puts "\tnew    - Create a new contact"
	puts "\tlist   - List all contacts"
	puts "\tshow   - Show a contact"
	puts "\tsearch - Search contacts"
	puts "\tupdate - update contact"
	puts "\tdelete - delete contact"
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
else
	puts "Invalid command"
end