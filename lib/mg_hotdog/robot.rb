require 'eventmachine'
require 'tinder'

module MgHotdog
  class Robot

    attr_accessor :parts
    attr_accessor :room

    def initialize(room_number)
      @parts = []
      @campfire = Connection.new
      @room_id = room_number
    end

    def wake_up
      puts @parts.inspect
       @room = @campfire.open(@room_id)

       @room.listen do |message|
         process(message)
       end
    end

    def process message
      @parts.each do |part|
        EM.defer { part.process(message, self) }
      end
    end

    def speak message
      @room.speak message
    end
  end

end

