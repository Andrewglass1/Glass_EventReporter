class EventManager
  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}
  EXIT_COMMANDS = ["quit", "q", "e", "exit", "peaceoutbro","x"]
  ALL_COMMANDS = {"load" => "loads a new file", "help" =>
  "shows a list of available commands",
  "queue count" => "counts the items in the queue",
  "queue clear" => "empties the queue",
  "queue print" => "prints the queue",
  "queue print by" => "prints sorted by the specified attribute",
  "queue save to" => "exports queue to a CSV",
  "find" => "load the queue with matching records",
  "print" => "prints the queue", "add find" =>
  "'add find attribute criteria'adds to your current queue",
  "subtract find" =>
  "'subtract find attribute criteria' subtracts from your queue",
  "find and" =>
  "'find attribute1 criteria1 and attribute2 criteria2' queries two paramters"}

  attr_accessor :attendees

  def initialize(filename, options = CSV_OPTIONS)
    puts "welcome to event reporter"
    @queue_instance = Queue.new
    @data_queue = []
  end

  def prompt
    @attributes = ["first_name", "last_name", "zipcode",
                   "state", "email_address", "city","street", "homephone"]
    command = ""
    until EXIT_COMMANDS.include?(command)
      printf "Enter a command: 'help' for instructions or 'exit' to quit>>"
      inputList = gets.strip.split(" ")
      if inputList == []
        puts 'ya gotta give me something to work with here'
      else
        command = inputList[0].downcase
        parser(command, inputList)
      end
    end
  end

  def parser(command, inputList)
    if EXIT_COMMANDS.include?(command)
        puts "peace out cubscout"
    elsif command == "help"
      help(inputList)
    elsif command == "queue" && inputList.length >1
      queue(inputList)
    elsif command == "find" && inputList.length >2
      find(inputList)
    elsif command == "load"
      load(inputList)
    elsif command == "add" && inputList[1] == "find"
        find_add(inputList[2],inputList[3..-1].join(" "))
    elsif command == "subtract" && inputList[1] == "find"
        find_subtract(inputList[2],inputList[3..-1].join(" "))
    else
      puts "sorry dude, invalid command. Type help for a list of commands"
    end
  end

  def load_attendees(file)
    self.attendees = file.collect { |line| Attendee.new(line) }
  end

  #help commands- not set yet
  def help(input)
    if input.length == 1
      puts 'here is a list of all commands and their function'
      ALL_COMMANDS.each {|key, value| puts "#{key}  ==  #{value}" }
    elsif ALL_COMMANDS.keys.include?(input[1..-1].join(" ").downcase)
      puts "this command " + ALL_COMMANDS[input[1..-1].join(" ").downcase]
    else
      puts "not a valid help function.  Type help for a list of commands"
    end
  end

  def load(input, options = CSV_OPTIONS)
    if input.length ==2
      begin
        load_attendees(CSV.open(input[1], options))
        puts "just loaded the file #{ input[1] }"
        @data_queue = []
      rescue
        puts "couldnt find that file. maybe check your pockets?"
      end
    elsif input.length ==1
        load_attendees(CSV.open("event_attendees.csv", options))
        puts "just loaded the default file"
        @data_queue = []
    else
      puts "that is not a valid load command"
    end
  end

  def find(input)
    if input.include? "and"
      indexer = input.index("and")
      attribute1=input[1]
      criteria1= input[2..indexer-1].join(" ")
      attribute2=input[indexer+1]
      criteria2 = input[indexer+2..-1].join(" ")
      find_multiple(attribute1,criteria1,attribute2,criteria2)
    elsif @attributes.include?(input[1])
      criteria = input[2..-1].join(" ")
      puts "querying records where #{ input[1] } is  #{ criteria }"
      @queue_instance.find(self.attendees, input[1], criteria)
    else
      puts "im not a genie, I cant search for: #{ input[1] }"
    end
  end

  def find_multiple(att1, crit1, att2, crit2)
    if @attributes.include?(att1) && @attributes.include?(att2)
      puts "searchin #{att1} with #{crit1}
            and #{att2} with #{crit2}"
      @queue_instance.find_and(self.attendees, att1, crit1, att2, crit2)
    else
      puts "I cant find based on #{attribute1} and #{attribute2}. Try again"
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
    if input.length == 2 && input[1] == "print"
        @queue_instance.queue_print
    elsif input[1..2].join(" ")== "print by" && input[3] != nil
      if @attributes.include?(input[3])
        @queue_instance.queue_print_by(input[3])
      else
        puts "I cant queue by #{ input[3] }, thats awkward...."
      end
    elsif input.length == 2 && input[1] == "clear"
        @queue_instance.queue_clear
    elsif input.length == 2 && input[1] == "count"
        @queue_instance.queue_length
    elsif input[1..2].join(" ")== "save to"  && input[3] != nil
        @queue_instance.output_data(input[3])
    else
        puts "sorry, not a valid queue function. Type help to list commands"
    end
  end
end