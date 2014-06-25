require 'pry'
require 'csv'
require './lib/attendee'
require './lib/queue'

class AttendeeRepository
  attr_reader :records

  def initialize(file="/Users/marcgarreau/Dropbox/Projects/Turing/event_reporter/fake.csv")
    @records  = []
    @contents = CSV.open(file, headers: true, header_converters: :symbol)
  end
  def build_people # have this take place in the initialize?
    @contents.each do |row|
      @records << Attendee.build(row)
    end
    return @records
    #
    # def load_file(filename)
    #   @contents = CSV.open(filename, headers: true, header_converters: :symbol)
    # end
  end

  # def initialize(file='./data/event_attendees.csv')
  #   @queue    = []
  #   @contents = CSV.open(file, headers: true, header_converters: :symbol)
  # end
  #
  # def build_people # have this take place in the initialize?
  #   @queue = []
  #   @contents.each do |row|
  #     @queue << Person.new(row)
  #   end
  # end
  #
  # def find_by(attribute, value)
  #   # Queue.new
  #   # @current_queue = []
  #   current_queue = @queue.select do |person|
  #     person[attribute] == value
  #   end
  #   Queue.build(current_queue)
  # end

end

if __FILE__ == $0

end
