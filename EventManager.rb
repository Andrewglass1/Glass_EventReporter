class EventManager
  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  EXIT_COMMANDS = ["quit", "q", "e", "exit", "peaceoutbro","x"]
  ALL_COMMANDS = {"load" => "loads a new file", "help" => "shows a list of available commands",
  "queue count" => "counts the items in the queue", "queue clear" => "empties the queue",
  "queue print" => "prints the queue", "queue print by" => "prints sorted by the specified attribute",
  "queue save to" => "exports queue to a CSV", "find" => "load the queue with matching records", 
  "print" => "prints the queue", "find add" => "command 'add find attribute criteria' to add to your current queue",
  "find subtract" => "command 'subtract find attribute criteria' to subtract from your current queue",
  "find and" => "command 'find attribute1 criteria1 and attribute2 criteria2' to query on two paramters"}

  attr_accessor :attendees

  #initializes and loads, starts automatically with object creation.  calls loads method, creates queue object
  def initialize(filename, options = CSV_OPTIONS)
    puts "welcome to event reporter"
    @queue_instance = Queue.new
    @data_queue = []

  end
  #loads file, loop generates a new attendee obejct for each line. does this have to be collect?
  def load_attendees(file)
    self.attendees = file.collect { |line| Attendee.new(line) }
  end

  #command line interface
  def prompt
    @attributes = ["first_name", "last_name", "zipcode", "state", "email_address", "city","street", "homephone"]
    command = ""
    until EXIT_COMMANDS.include?(command)

      printf "Please enter a command.  Type 'help' for instructions or 'exit' to quit>>>  "
      input = gets.strip
      inputList = input.split(" ")
      if inputList[0]
        command = inputList[0].downcase
      else
        command = "blah"
      end

      if EXIT_COMMANDS.include?(command)
          puts "peace out cubscout"

      elsif command == "help" && inputList.length ==1
          help("general")

      elsif command == "help" && inputList.length >1 
          help(inputList[1..-1].join(" "))

      elsif command == "queue" && inputList.length ==1
          queue("general")

      elsif command == "queue" && inputList.length >1
          queue(inputList[1..-1].join(" "))

      elsif command == "find" && inputList.length == 3
          find(inputList[1],inputList[2])

      elsif command == "find" && inputList.length == 6 && inputList[3] == "and"
          find_multiple(inputList[1],inputList[2], inputList[4], inputList[5])

      elsif command == "add" && inputList.length == 4 && inputList[1] == "find" 
          find_add(inputList[2],inputList[3])

       elsif command == "subtract" && inputList.length == 4 && inputList[1] == "find"
          find_subtract(inputList[2],inputList[3])       
        
      elsif command == "load" && inputList.length == 2
          load(inputList[1..-1].join(" "))

      elsif command == "find" && inputList.length != 3
          puts 'not a valid find command'

      elsif command == "load" && inputList.length != 2
          puts 'not a valid load command'

      elsif EXIT_COMMANDS.include?(command)
          #donothing
      else
        puts "sorry dude, I'm not sure what the hell #{ input } means.  Type help for a list of commands"
      end
    end
  end

  #help commands- not set yet
  def help(input)
    if input == "general"
      puts 'here is a list of all commands and their function'
      ALL_COMMANDS.each {|key, value| puts "#{key}  ==  #{value}" }

    elsif ALL_COMMANDS.keys.include?(input)
      puts input + ": " + ALL_COMMANDS[input]
    else
      puts "sorry, that is not a valid help function.  Type help for a list of commands"
    end
  end


  def load(input, options = CSV_OPTIONS)
    begin
      load_attendees(CSV.open(input, options))
      puts "just loaded the file #{ input }"
      @data_queue = []
    rescue
      puts "couldnt find that file. maybe check your pockets?"
    end
  end

  def find(attribute, criteria)
    if @attributes.include?(attribute)
      puts "querying records where #{ attribute } is  #{ criteria }"
      @queue_instance.find(self.attendees, attribute, criteria)
    else
      puts "im not a genie, I cant search for: #{ attribute }"
    end
  end

  def find_multiple(attribute1, criteria1, attribute2, criteria2)
    if @attributes.include?(attribute1) && @attributes.include?(attribute2)
      puts " will query for #{attribute1} with #{criteria1} annnnnnnd #{attribute2} with #{criteria2}"
      @queue_instance.find_and(self.attendees, attribute1, criteria1, attribute2, criteria2)
    else
      puts "I cant be find based on #{attribute1} and #{attribute2}.  Take a deep breath, get off your high horse and try again"
    end
  end

  def find_subtract(attribute, criteria)
    if @attributes.include?(attribute)
      puts "subtracting records where #{ attribute } is  #{ criteria }"
      @queue_instance.find_minus(self.attendees, attribute, criteria)
    else
      puts "im not a genie, I cant search for: #{ attribute }"
    end
  end

  def find_add(attribute, criteria)
    if @attributes.include?(attribute)
      puts "adding records where #{ attribute } is  #{ criteria }"
      @queue_instance.find_plus(self.attendees, attribute, criteria)
    else
      puts "im not a genie, I cant search for: #{ attribute }"
    end
  end

  def queue(input)
    input = input.split(" ")

    if input.length == 1 && input[0] == "print"
        @queue_instance.queue_print

    elsif input[0..1].join(" ")== "print by" && input[2] != nil 
      attribute = input[2]
      if @attributes.include?(attribute)
        @queue_instance.queue_print_by(attribute)
      else
        puts "I cant queue by #{ attribute }, thats awkward...."
      end

    elsif input.length == 1 && input[0] == "clear"
        @queue_instance.queue_clear

    elsif input.length == 1 && input[0] == "count"
        @queue_instance.queue_length


    elsif input[0..1].join(" ")== "save to"  && input[2] != nil
        filename = input[2]
        @queue_instance.output_data(filename)
    else
        puts "sorry, that is not a valid queue function. Type help for a list of commands"
    end
  end    
end