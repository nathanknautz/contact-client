require 'unirest'

url = "http://localhost:3000/"

puts "Choose an option:"
puts "     [1] Show one contact"
puts "     [2] Show all contacts"

input_option = gets.chomp

if input_option == "1"
  url += "one_contact_url"
else
  url += "all_contacts"
end

response = Unirest.get(url)
contacts = response.body
puts JSON.pretty_generate(contacts)
