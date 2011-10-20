require 'httparty'

class GistPart
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize 
     @lock = Mutex.new
  end

  def process(message,robot)
    @lock.synchronize do
      if message.body && message.body.match(/gist me!/i)
        process_text message,robot
      end

      if message.type && message.type.match(/PasteMessage/)
        process_paste message,robot
      end
    end
  end

  def process_text message, robot


    if last_paste_is_not_stale
      robot.speak('I sense the need for a gist!')
        
      data =
        {
          "description" => "THE CRAFSTMANSHIP OF MG HOTDOG",
          "public" => true,
          "files" =>  {
            "STUFF_YOU_PASTED.txt" => {
              "content" =>  "String file contents"
            }
          }
        }

      response = GistPart.post '/gists', data

    else

    robot.speak('Nobody has pasted anything lately')
      
    end

  end

  def process_paste message, robot

  
  end

  def last_paste_is_not_stale
    false
  end
end
