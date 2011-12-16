class SiPart
  def process(message, robot)
    robot.speak 'si' if /^si$/i =~ message.body && !(/MG HOTDOG/ =~ message.user)
  end
end
