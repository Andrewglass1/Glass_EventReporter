
class Attendee
  INVALID_ZIPCODE = "00000"
  INVALID_PHONE = "0000000000"

  attr_accessor :first_name,
                :last_name,
                :homephone,
                :email_address,
                :city,
                :state,
                :zipcode,
                :street



  def initialize(attributes)
    self.first_name = attributes[:first_name].to_s
    self.last_name = attributes[:last_name].to_s
    self.homephone = clean_phone_number(attributes[:homephone]).to_s
    self.email_address = attributes[:email_address].to_s
    self.city = attributes[:city].to_s
    self.zipcode= clean_zipcode(attributes[:zipcode]).to_s
    self.street = attributes[:street].to_s
    self.state = attributes[:state].to_s
  end

  def clean_zipcode(original)
    if original.nil?
      INVALID_ZIPCODE
    elsif original.length <5
      until original.length ==5
      original.insert 0,"0"
      end
      original
    else
      original
    end
  end


  def clean_phone_number(phone_number)
    phone_number = phone_number.scan(/\d/).join
    if phone_number.length == 10
      phone_number
    elsif phone_number.length == 11 && phone_number.start_with?("1")
      phone_number[1..-1]
    elsif phone_number.length != 10
      INVALID_PHONE
    else
      phone_number
    end
  end

end





