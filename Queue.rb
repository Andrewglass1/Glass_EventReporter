class Queue
  HEADERS = [:last_name, :first_name, :email_address, :zipcode, :state, :city, :street, :homephone]


#loops thourgh attendees, selects attendee for atendee.attribute(sent in with 'intern' for some reason??- nessecary?)
  def find(attendees, attribute, criteria)
    if attendees
      @data_queue = attendees.select { |attendee| attendee.send(attribute.intern).downcase.strip == criteria.downcase.strip}
      puts "query snatched #{@data_queue.length} records"
    else
      puts ""
      puts 'dude, stop trying to break me.  i know you dont have any data to search from'
      puts ""
    end
  end

  def find_and(attendees, attribute1, criteria1, attribute2, criteria2)
    if attendees
      @data_queue1 = attendees.select { |attendee| attendee.send(attribute1.intern).downcase.strip == criteria1.downcase.strip}
      @data_queue = @data_queue1.select { |attendee| attendee.send(attribute2.intern).downcase.strip == criteria2.downcase.strip}
      puts "query snatched #{@data_queue.length} records"
    else
      puts ""
      puts 'dude, stop trying to break me.  i know you dont have any data to search from'
      puts ""
    end
  end

  def find_minus(attendees, attribute, criteria)
    if attendees && @data_queue != [] && @data_queue
      @data_queue_subtract = @data_queue.select { |attendee| attendee.send(attribute.intern).downcase.strip == criteria.downcase.strip}
      @data_queue = @data_queue - @data_queue_subtract
      @dat
      puts "I subtracted #{@data_queue_subtract.length } records so you have a total of #{@data_queue.length}"
    else
      puts "I dont have queue to subtract from"
    end
  end

  def find_plus(attendees,attribute, criteria)
    if attendees && @data_queue != [] && @data_queue
      @data_queue_add = attendees.select { |attendee| attendee.send(attribute.intern).downcase.strip == criteria.downcase.strip}
      @original_records =@data_queue.length
      @data_queue = @data_queue | @data_queue_add

      puts "I added #{@data_queue.length - @original_records} records so you have a total of #{@data_queue.length}"
    else
      puts "whoah, there is no queue to add to.  you can only add or subtract when you have a queue"
    end
  end



#$if @data_queue tests to see if it is not nil
  def queue_clear
    if @data_queue
      @data_queue.clear
      puts "the queue is now clear: #{ @data_queue.length } records"
    else
      puts 'there is no current queue'
    end
  end

  def queue_length
    if @data_queue
      puts "your queue is stashing #{ @data_queue.length } records"
    else
      puts 'there is no current queue- so the count is 0'
    end
  end

  def queue_print_by(attribute)
    if @data_queue
      @data_queue.sort_by! { |attendee| attendee.send(attribute.intern)}
      queue_print
    else
      puts 'there is no current queue'
    end
  end

  def queue_print
    #taking in these variables- from where??


    if @data_queue && @data_queue!= []
      last_name_length
      first_name_length
      email_address_length
      state_length
      city_length
      address_length
      zipcode_length
      homephone_length

      #PUTS HEADER
      #puts "#{ 'LASTNAME'.ljust(20, " ")}  #{'FIRSTNAME'.ljust(20, " ")} #{'EMAIL'.ljust(41, " ")} #{'ZIPCODE'.ljust(8, " ")} #{'STATE'.ljust(10, " ")} #{'CITY'.ljust(14, " ")}  #{'ADDRESS'.ljust(30, " ")}" 
      puts "#{ 'LASTNAME'.ljust(@last_name_col, " ")}  #{'FIRSTNAME'.ljust(@first_name_col, " ")} #{'EMAIL'.ljust(@email_address_col, " ")} #{'ZIPCODE'.ljust(@zipcode_col, " ")} #{'STATE'.ljust(@state_col, " ")} #{'CITY'.ljust(@city_col, " ")}  #{'ADDRESS'.ljust(@address_col, " ")} #{'PHONE'.ljust(@homephone_col, " ")}" 

      if @data_queue.length <10
        #for each line in data queue (named attendee) put  each attribute, left alligned
        @data_queue.each do |attendee|
          #puts "#{attendee.last_name.to_s.ljust(20, " ")} #{attendee.first_name.to_s.ljust(20, " ")} #{attendee.email_address.to_s.ljust(41, " ")} #{attendee.zipcode.to_s.ljust(8, " ")} #{attendee.state.to_s.ljust(10, " ")} #{attendee.city.to_s.ljust(14, " ")} #{attendee.street.to_s.ljust(30, " ")}"
          puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} #{attendee.first_name.to_s.ljust(@first_name_col, " ")} #{attendee.email_address.to_s.ljust(@email_address_col, " ")} #{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} #{attendee.state.to_s.ljust(@state_col, " ")} #{attendee.city.to_s.ljust(@city_col, " ")} #{attendee.street.to_s.ljust(@address_col, " ")} #{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
        end
        puts ""
        puts ""
      else
        @data_queue.each_with_index do |attendee, i|
          break if i ==10
          #puts "#{attendee.last_name.to_s.ljust(20, " ")} #{attendee.first_name.to_s.ljust(20, " ")} #{attendee.email_address.to_s.ljust(41, " ")} #{attendee.zipcode.to_s.ljust(8, " ")} #{attendee.state.to_s.ljust(10, " ")} #{attendee.city.to_s.ljust(14, " ")} #{attendee.street.to_s.ljust(30, " ")}"
          puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} #{attendee.first_name.to_s.ljust(@first_name_col, " ")} #{attendee.email_address.to_s.ljust(@email_address_col, " ")} #{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} #{attendee.state.to_s.ljust(@state_col, " ")} #{attendee.city.to_s.ljust(@city_col, " ")} #{attendee.street.to_s.ljust(@address_col, " ")} #{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
        end
        puts ""
        puts "returned first ten records.  press enter or space to print rest or any key to return to prompt"
        char = get_character

        if char == 32 || char ==13
          @data_queue.each_with_index do |attendee, i|
            next if i <10
            #puts "#{attendee.last_name.to_s.ljust(20, " ")} #{attendee.first_name.to_s.ljust(20, " ")} #{attendee.email_address.to_s.ljust(41, " ")} #{attendee.zipcode.to_s.ljust(8, " ")} #{attendee.state.to_s.ljust(10, " ")} #{attendee.city.to_s.ljust(14, " ")} #{attendee.street.to_s.ljust(30, " ")}"
            puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} #{attendee.first_name.to_s.ljust(@first_name_col, " ")} #{attendee.email_address.to_s.ljust(@email_address_col, " ")} #{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} #{attendee.state.to_s.ljust(@state_col, " ")} #{attendee.city.to_s.ljust(@city_col, " ")} #{attendee.street.to_s.ljust(@address_col, " ")} #{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
          end
          puts ""
        else
          puts 'thanks for querying'
          puts ""
        end
      end

      # puts 'last n' 
      # puts @last_name_col
      # puts 'first'
      # puts @first_name_col
      # puts 'email' 
      # puts @email_address_col
      # puts 'city' 
      # puts @city_col
      # puts 'addre'
      # puts @address_col
      # puts 'state'
      # puts @state_col
      # puts 'phone'
      # puts @homephone_col

    #if the data queue is blank
    elsif @data_queue == []
      puts "#{ 'LASTNAME'.ljust(20, " ")}  #{'FIRSTNAME'.ljust(15, " ")} #{'EMAIL'.ljust(43, " ")} #{'ZIPCODE'.ljust(10, " ")} #{'STATE'.ljust(10, " ")} #{'CITY'.ljust(14, " ")}  #{'ADDRESS'.ljust(35, " ")}" 
      puts "this is where your records would be if you had them. but you don't... so theres nothing here. "
      puts ""
      puts ""
      puts ""

    else
      puts "calm down buddy, you haven't even made a queue yet"
    end
  end

  #figuring out otpimal length for each column


  def last_name_length
    if @data_queue
      last_name_lengths = @data_queue.collect do |attendee|
        attendee.last_name.length
      end
      @last_name_col = last_name_lengths.sort.last
      @last_name_col = @last_name_col + 5
    else
      @last_name_col = 20
    end
  end

  def first_name_length
    if @data_queue
      first_name_lengths = @data_queue.collect do |attendee|
        attendee.first_name.length
      end
      @first_name_col = first_name_lengths.sort.last 
      @first_name_col = @first_name_col +5
    else
      @first_name_col = 20
    end
  end

  def email_address_length
    if @data_queue
      email_address_lengths = @data_queue.collect do |attendee|
        attendee.email_address.to_s.length
      end
      @email_address_col = email_address_lengths.sort.last
      @email_address_col = @email_address_col +5
    else
      @email_address_col = 41
    end
  end

  def city_length
    if @data_queue
      city_lengths = @data_queue.collect do |attendee|
        attendee.city.to_s.length
      end
      @city_col = city_lengths.sort.last
      @city_col = @city_col + 5
    else
      @city_col = 8
    end
  end

  def state_length
    if @data_queue
      state_lengths = @data_queue.collect do |attendee|
        attendee.state.to_s.length
      end
      @state_col = state_lengths.sort.last
      @state_col = @state_col +5
    else
      @state_col = 10
    end
  end

  def zipcode_length
    if @data_queue
      zipcode_lengths = @data_queue.collect do |attendee|
        attendee.zipcode.to_s.length
      end
      @zipcode_col = zipcode_lengths.sort.last
      @zipcode_col = @zipcode_col +5
    else
      @zipcode_col = 8  
    end
  end

  def address_length
    if @data_queue
      address_lengths = @data_queue.collect do |attendee|
        attendee.street.to_s.length
      end
      @address_col = address_lengths.sort.last
      @address_col = @address_col +5
    else
      @address_col = 30
    end
  end

  def homephone_length
    if @data_queue
      phone_lengths = @data_queue.collect do |attendee|
        attendee.homephone.to_s.length
      end
      @homephone_col = phone_lengths.sort.last
      @homephone_col = @homephone_col +5
    else
      @homephone_col = 30
    end
  end



  # GET THIS SHIT WORKING TOMORROW!!!!!


  # def field_length
  #   col_fields = ["last_name", "first_name", "email_address", "state", "city", "address"]
  #   col_fields.each do |field|

  #     singleton_class.class_eval do 
  #       attr_accessor "#{field}_cols".to_sym
  #       attr_accessor "#{field}_lengths".to_sym
  #     end

  #     field_lengths = @data_queue.collect do |attendee|
  #         if attendee.send("#{field}").nil?
  #           #nothing
  #         else
  #           attendee.send("#{field}").length
  #         end
  #     end
  #     send("#{ field }_lengths=", field_lengths) 

  #     field_cols = send("#{ field }_lengths").sort.last
  #     send("#{ field }_cols=", field_cols) 
  #   end
  # end

  #method creates new file
  def output_data(filename)
    if @data_queue
      output = CSV.open(filename,"w")
        #shovels my HEADERS constant into output. each header is 'with its indexes'
        #guess it doesnt matter that ive named each instance header, right?
        output << HEADERS.each_with_index{|header|}
        #for each line in queue, 'do'
      @data_queue.each do |line|
        #collecting the output for each line, looping for each of the headers
        output << HEADERS.collect{|header| line.send(header)}
      end
      output.close
      puts "saved the queue as #{ filename }"
      #close file
    elsif
        output = CSV.open(filename,"w")
        output << HEADERS.each_with_index{|header|}
        output.close
        puts "fine, I saved the queue as #{ filename }, but I dont see the point- theres nothing in there!"
    end
  end
end





