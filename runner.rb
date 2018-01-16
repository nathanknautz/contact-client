require 'unirest'

response = Unirest.get("http://localhost:3000/one_contact_url")

contacts = response.body
puts JSON.pretty_generate(contacts)
