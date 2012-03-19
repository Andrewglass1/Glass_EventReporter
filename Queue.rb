class Queue
  HEADERS = [:last_name, :first_name, :email_address,
             :zipcode, :state, :city, :street, :homephone]

  def find(attendees, attribute, criteria)
    if attendees
      @data_queue = attendees.select do |attendee|
        data = attendee.send(attribute.intern).downcase.strip
        data == criteria.downcase.strip
      end
      puts "query snatched #{@data_queue.length} records"
    else
      puts ""
      puts 'stop trying to break me, you didnt load data to search from'
      puts ""
    end
  end

  def find_and(attendees, attribute1, criteria1, attribute2, criteria2)
    if attendees
      @data_queue1 = attendees.select do |attendee|
        data = attendee.send(attribute1.intern).downcase.strip
        data == criteria1.downcase.strip
      end
      @data_queue = @data_queue1.select do |attendee|
        data = attendee.send(attribute2.intern).downcase.strip
        data == criteria2.downcase.strip
      end
      puts "query snatched #{@data_queue.length} records"
    else
      puts ""
      puts 'stop trying to break me, you didnt load data to search from'
      puts ""
    end
  end

  def find_minus(attendees, attribute, criteria)
    if attendees && @data_queue != [] && @data_queue
      @data_queue_subtract = @data_queue.select do |attendee|
        data = attendee.send(attribute.intern).downcase.strip
        data == criteria.downcase.strip
      end
      @data_queue = @data_queue - @data_queue_subtract
      subt = @data_queue_subtract.length
      length = @data_queue.length
      puts "subtracted #{subt } to total #{length}"
    else
      puts "I dont have queue to subtract from"
    end
  end

  def find_plus(attendees,attribute, criteria)
    if attendees && @data_queue != [] && @data_queue
      @data_queue_add = attendees.select do |attendee|
        data = attendee.send(attribute.intern).downcase.strip
        data == criteria.downcase.strip
      end
      @original_records =@data_queue.length
      @data_queue = @data_queue | @data_queue_add
      addnum = @data_queue.length - @original_records

      puts "adds #{addnum} to total #{@data_queue.length}"
    else
      puts "no queue to add to, can only add or subtract when you have a queue"
    end
  end

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
    if @data_queue && @data_queue!= []
      last_name_length
      first_name_length
      email_address_length
      state_length
      city_length
      address_length
      zipcode_length
      homephone_length

      puts "#{ 'LASTNAME'.ljust(@last_name_col, " ")} " +
           "#{'FIRSTNAME'.ljust(@first_name_col, " ")} " +
           "#{'EMAIL'.ljust(@email_col, " ")} " +
           "#{'ZIPCODE'.ljust(@zipcode_col, " ")} " +
           "#{'STATE'.ljust(@state_col, " ")} "+
           "#{'CITY'.ljust(@city_col, " ")} "+
           "#{'ADDRESS'.ljust(@address_col, " ")} "+
           "#{'PHONE'.ljust(@homephone_col, " ")}"
      if @data_queue.length <10
        @data_queue.each do |attendee|
          puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} "+
               "#{attendee.first_name.to_s.ljust(@first_name_col, " ")} "+
               "#{attendee.email_address.to_s.ljust(@email_col, " ")} "+
               "#{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} "+
               "#{attendee.state.to_s.ljust(@state_col, " ")} "+
               "#{attendee.city.to_s.ljust(@city_col, " ")} "+
               "#{attendee.street.to_s.ljust(@address_col, " ")} "+
               "#{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
        end
        puts ""
        puts ""
      else
        @data_queue.each_with_index do |attendee, i|
          break if i ==10
          puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} "+
               "#{attendee.first_name.to_s.ljust(@first_name_col, " ")} "+
               "#{attendee.email_address.to_s.ljust(@email_col, " ")} "+
               "#{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} "+
               "#{attendee.state.to_s.ljust(@state_col, " ")} "+
               "#{attendee.city.to_s.ljust(@city_col, " ")} "+
               "#{attendee.street.to_s.ljust(@address_col, " ")} "+
               "#{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
        end
        puts ""
        puts "printed 10 records,hit enter or space for rest or any key to end"
        char = get_character

        if char == 32 || char ==13
          @data_queue.each_with_index do |attendee, i|
            next if i <10
            puts "#{attendee.last_name.to_s.ljust(@last_name_col, " ")} "+
                 "#{attendee.first_name.to_s.ljust(@first_name_col, " ")} "+
                 "#{attendee.email_address.to_s.ljust(@email_col, " ")} "+
                 "#{attendee.zipcode.to_s.ljust(@zipcode_col, " ")} "+
                 "#{attendee.state.to_s.ljust(@state_col, " ")} "+
                 "#{attendee.city.to_s.ljust(@city_col, " ")} "+
                 "#{attendee.street.to_s.ljust(@address_col, " ")} "+
                 "#{attendee.homephone.to_s.ljust(@homephone_col, " ")}"
          end
          puts ""
        else
          puts 'thanks for querying'
          puts ""
        end
      end

    elsif @data_queue == []
      puts "#{ 'LASTNAME'.ljust(20, " ")} "+
           "#{'FIRSTNAME'.ljust(15, " ")} "+
           "#{'EMAIL'.ljust(43, " ")} "+
           "#{'ZIPCODE'.ljust(10, " ")} "+
           "#{'STATE'.ljust(10, " ")} "+
           "#{'CITY'.ljust(14, " ")}  "+
           "#{'ADDRESS'.ljust(35, " ")}"+
           "#{'PHONE'.ljust(12, " ")}"
      puts "this is where records would be, but you have none"
      puts ""
      puts ""
      puts ""

    else
      puts "calm down buddy, you haven't even made a queue yet"
    end
  end


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
      @email_col = email_address_lengths.sort.last
      @email_col = @email_col +5
    else
      @email_col = 41
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

  def output_data(filename)
    if @data_queue
      output = CSV.open(filename,"w")
        output << HEADERS.each_with_index{|header|}
      @data_queue.each do |line|
        output << HEADERS.collect{|header| line.send(header)}
      end
      output.close
      puts "saved the queue as #{ filename }"

    elsif
        output = CSV.open(filename,"w")
        output << HEADERS.each_with_index{|header|}
        output.close
        puts "I saved the queue as #{ filename }, but theres nothing in there!"
    end
  end
end





