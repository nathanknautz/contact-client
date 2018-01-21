require 'unirest'

system "clear"

puts "Welcome to my Contacts application!"
puts "Choose an option below:"
puts "     [1] Show all contacts"
puts "     [2] Show one contact"
puts "     [3] Update a contact"
puts "     [4] Create a new contact"
puts "     [5] Delete a contact"

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
  print "Which Contact do you want to update? Enter ID: "
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  contact_data = {}
  print "First Name (#{contact["first_name"]}): "
  contact_data[:first_name] = gets.chomp
  print "Last Name (#{contact["last_name"]}): "
  contact_data[:last_name] = gets.chomp
  print "Email (#{contact["email"]}): "
  contact_data[:email] = gets.chomp
  print "Phone Number (#{contact["phone_number"]}): "
  contact_data[:phone_number] = gets.chomp
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
    print "Enter the email: "
    contact_data[:email] = gets.chomp
    print "Enter the phone number: "
    contact_data[:phone_number] = gets.chomp
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
    
