require 'spec_helper'
require 'mg_hotdog/parts/si_part.rb'

describe SiPart do
  before :each do
    mock_message_and_robot
  end

  it 'should repeat "si"' do
    @message.stub(:body).and_return('si')
    @robot.should_receive(:speak).with(/si/)
    SiPart.new.process(@message,@robot)
  end

  it "shouldn't repeat itself" do
    @message.stub(:body).and_return('si')
    @message.stub(:user).and_return('MG HOTDOG')

    @robot.should_not_receive(:speak)

    SiPart.new.process(@message, @robot)
  end

  it "should not respond to si in the middle of a word" do
    @message.stub(:body).and_return('since')

    @robot.should_not_receive(:speak)

    SiPart.new.process(@message, @robot)

  end
end
