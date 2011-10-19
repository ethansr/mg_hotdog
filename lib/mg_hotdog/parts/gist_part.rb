require 'httparty'

class GistPart
  @lock = Mutex.new

  include HTTParty
  base_uri 'https://api.github.com'

  def process(message,robot)

      if message.body && message.body.match(/gist me!/i)
        process_text message,robot
      end

      if message.type && message.type.match(/PasteMessage/)
        process_paste message,robot
      end
  end

  def process_text message, robot

    robot.speak('I sense the need for a gist!')

    @lock.synchronize do
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
    end
      response = GistPart.post '/gists', data


  end

  def process_paste message, robot

  
  end
end
