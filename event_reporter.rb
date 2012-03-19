#requirements

require "bundler"
Bundler.require
$LOAD_PATH << './'
require 'attendee'
require 'Queue'
require 'EventManager'
include HighLine::SystemExtensions

#cane --style-glob '**/*.rb' --abc-glob '**/*.rb'

#script
em = EventManager.new("event_attendees.csv")
em.prompt


#em.print_zipcodes
#em.print_zipcode
#em.print_phone
#em.load_file("alt_file.csv")

#queue_instance=Queue.new
#queue_instance.find(em.attendees, "NY", "state") # "NC")
