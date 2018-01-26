require_relative 'controllers/contacts_controllers'
require_relative 'models/contact'
require_relative 'views/contacts_view'

class Frontend
  include ContactsController
  include ContactsViews

  def run

    require 'unirest'
    require 'paint'

    system "clear"

    puts Paint["Welcome to my Contacts application!".center(70), :red, :blue]
    puts Paint["Choose an option below:".center(70), :red, :blue]
    puts Paint["[1] Show all contacts".ljust(70), :red, :blue]
    puts Paint["  [1.1] Search contacts".ljust(70), :red, :blue]
    puts Paint["  [1.2] Sort all contacts".ljust(70), :red, :blue]
    puts Paint["[2] Show one contact".ljust(70), :red, :blue]
    puts Paint["[3] Update a contact".ljust(70), :red, :blue]
    puts Paint["[4] Create a new contact".ljust(70), :red, :blue]
    puts Paint["[5] Delete a contact".ljust(70), :red, :blue]

    input_option = gets.chomp

    if input_option == "1"
      contacts_index_action
    elsif input_option == "1.1"
      print "Enter search term: "
      search_term = gets.chomp
      response = Unirest.get("http://localhost:3000/contacts?search=#{search_term}")
      contacts = response.body 
      puts JSON.pretty_generate(contacts)
    elsif input_option == "1.2"
      print "Sort on: "
      sort_value = gets.chomp
      response = Unirest.get("http://localhost:3000/contacts?sort=#{sort_value}")
      contacts = response.body 
      puts JSON.pretty_generate(contacts)
    elsif input_option == "2"
      contacts_show_action
    elsif input_option == "3"
       contacts_update_action
    elsif input_option == "4"
       contacts_create_action
    elsif input_option == "5"
       contacts_destroy_action
    end 

  end

end