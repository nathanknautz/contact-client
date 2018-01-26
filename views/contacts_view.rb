module  ContactsViews

  def contacts_show_view(contact)
    puts "=============="
    puts contact.full_name
    puts contact.email  
    puts contact.phone_number
    puts contact.bio
    puts 
  end

  def contacts_index_view(contacts)
     
    contacts.each do |contact|
      puts "=============="
      puts contact.full_name
      puts contact.email  
      puts contact.phone_number
      puts contact.bio
      puts 
    end
  end

end