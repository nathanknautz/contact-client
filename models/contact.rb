class Contact
  attr_accessor :first_name, :middle_name, :last_name, :full_name, :email, :phone_number, :bio
  
  def initialize(input_data)
    @first_name = input_data["first_name"]
    @middle_name = input_data["middle_name"]
    @last_name = input_data["last_name"]
    @full_name = input_data["full_name"]
    @email = input_data["email"]
    @phone_number = input_data["phone_number"]
    @bio = input_data["bio"]

  end

end