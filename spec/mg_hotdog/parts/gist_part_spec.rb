require 'spec_helper'
require 'mg_hotdog/parts/gist_part'

describe GistPart do

  describe "process a message" do
    before :each do
      mock_message_and_robot

      GistPart.stub(:post)
    end
    it "should respond to 'gist me!'" do
      @message.stub(:body).and_return('gist me!')

      @robot.should_receive(:speak)

      GistPart.new.process(@message, @robot)
    end

    it "should not respond to anything else" do
      @message.stub(:body).and_return('rar')

      GistPart.new.process(@message, @robot)
    end

    it "should post a gist" do
      @message.stub(:body).and_return('gist me!')
      GistPart.should_receive(:post)
      @robot.should_receive(:speak)

      GistPart.new.process(@message,@robot)      
    
    end
  end
end
