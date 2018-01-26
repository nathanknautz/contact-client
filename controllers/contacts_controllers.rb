module ContactsController
  
  def contacts_index_action
    response = Unirest.get("http://localhost:3000/contacts")
    contact_hashs = response.body 
    contacts = []
    
    contact_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end
    contacts_index_view(contacts)
  end
  
  def contacts_create_action
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
    if response.code == 200
      contact_data = response.body 
      puts JSON.pretty_generate(contact_data)
    else
      errors = response.body
      errors.each do |error|
        puts error 
      end
    end
  end
  
  def contacts_show_action
    system "clear"
    print "Which Contact ID do you want to look up? "
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    contact_hash = response.body 
    contact = Contact.new(contact_hash)
    contacts_show_view(contact)

  end
  
  def contacts_update_action
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
    if response.code == 200
      contact_data = response.body 
      puts JSON.pretty_generate(contact_data)
    else
      errors = response.body
      errors.each do |error|
        puts error 
      end
    end
  end
  
  def contacts_destroy_action
    system "clear"
    print "Which contact do you want to delete? ID: "
    input_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
    message = response.body 
    puts message['message']
  end

end
