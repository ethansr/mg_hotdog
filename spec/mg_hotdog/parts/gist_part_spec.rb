require 'spec_helper'
require 'mg_hotdog/parts/gist_part'

describe GistPart do

  describe "process a message" do
    before :each do
      mock_message_and_robot
    end

    describe "process a request for a gist" do
      before :each do
        @message.stub(:type).and_return('TextMessage')
        GistPart.stub(:post)
      end

      it "should respond to 'gist me!'" do
        stub_gist_request
        @robot.should_receive(:speak)

        GistPart.new.process(@message, @robot)
      end

      it "should not respond to anything else" do
        @message.stub(:body).and_return('rar')

        GistPart.new.process(@message, @robot)
      end

      it "should post a gist" do
        stub_gist_request
        GistPart.should_receive(:post)
        @robot.should_receive(:speak)

        GistPart.new.process(@message,@robot)      
      
      end

      it "should complain if it doesn't have anything to gist" do
        stub_gist_request

        @robot.should_receive(:speak).with("Nobody has pasted anything lately")

        GistPart.new.process(@message,@robot)
      end
    end

    describe "process a paste message" do
      before :each do
        message.stub(:type).and_return('TextMessage')
      end

      it "should cache the last paste message" do
        
      end

      it "should consider a paste stale after 1 minute" do

      end
    end
  end
end
