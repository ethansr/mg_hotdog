class SiPart
  def process(message, robot)
    robot.speak 'si' if message.body && message.body.match(/^si$/i) && !message.user.match(/MG HOTDOG/)
  end
end
