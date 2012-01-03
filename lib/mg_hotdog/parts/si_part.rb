class SiPart
  def process(message, robot)
    if message.body && 
       message.body.match(/^si$/i) && 
       !message.user.name.match(/MG HOTDOG/)
      robot.speak( 'si')
    end
  end
end
