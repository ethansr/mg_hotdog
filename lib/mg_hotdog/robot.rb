require 'eventmachine'
require 'tinder'

module MgHotdog
  class Robot

    attr_accessor :parts
    attr_accessor :room
    attr_accessor :database

    def initialize(room_number, database_path)
      @parts = []
      @campfire = Connection.new
      @room_id = room_number
      @database = Database.new(database_path)
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
        EM.defer {
          begin
            part.process(message, self)
          rescue Exception => e
            speak("I cannot do that at this moment due to: #{e.class.to_s}: #{e.message}.")
            puts ("#{e.class.to_s}: #{e.message}")
          end
        }
      end
    end

    def speak message
      @room.speak message
    end
  end

end

