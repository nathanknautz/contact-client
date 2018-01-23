require 'unirest'
require 'paint'

system "clear"

puts Paint["Welcome to my Contacts application!".center(70), :red, :blue]
puts Paint["Choose an option below:".center(70), :red, :blue]
puts Paint["[1] Show all contacts".ljust(70), :red, :blue]
puts Paint["[2] Show one contact".ljust(70), :red, :blue]
puts Paint["[3] Update a contact".ljust(70), :red, :blue]
puts Paint["[4] Create a new contact".ljust(70), :red, :blue]
puts Paint["[5] Delete a contact".ljust(70), :red, :blue]

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body 
  puts JSON.pretty_generate(contacts)
elsif input_option == "2"
  system "clear"
  print "Which Contact ID do you want to look up? "
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body 
  puts JSON.pretty_generate(contact)
elsif input_option == "3"
  system 'clear'
  print Paint["Which Contact do you want to update? Enter ID: ", :red, :blue]
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  contact_data = {}
  print "First Name (#{contact["first_name"]}): "
  contact_data[:first_name] = gets.chomp
  print "Last Name (#{contact["last_name"]}): "
  contact_data[:last_name] = gets.chomp
  print "Middle Name (#{contact["middle_name"]}): "
  contact_data[:middle_name] = gets.chomp
  print "Email (#{contact["email"]}): "
  contact_data[:email] = gets.chomp
  print "Phone Number (#{contact["phone_number"]}): "
  contact_data[:phone_number] = gets.chomp
  print "Bio(#{contact["bio"]}): "
  contact_data[:bio] = gets.chomp
  contact_data.delete_if {|k,v| v.empty?}
  response = Unirest.patch("http://localhost:3000/contacts/#{input_id}",
                            parameters: contact_data)
  elsif input_option == "4"
    system "clear"
    contact_data = {}
    print "Enter the first name: "
    contact_data[:first_name] = gets.chomp
    print "Enter the last name: "
    contact_data[:last_name] = gets.chomp
    print "Middle Name: "
    contact_data[:middle_name] = gets.chomp
    print "Enter the email: "
    contact_data[:email] = gets.chomp
    print "Enter the phone number: "
    contact_data[:phone_number] = gets.chomp
    print "Bio: "
    contact_data[:bio] = gets.chomp
    response = Unirest.post("http://localhost:3000/contacts",
                            parameters: contact_data)
  elsif input_option == "5"
    system "clear"
    print "Which contact do you want to delete? ID: "
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    message = response.body 
    puts message['message']
  end 
    
