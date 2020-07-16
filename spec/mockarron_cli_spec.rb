require 'spec_helper'
require "mockarron/cli"

RSpec.describe Mockarron::CLI do
  describe "Command: server" do
    it "is expected to start the web server and output a message" do
      expect(Mockarron::WebServer).to receive(:run!).and_return(true)
      expect { subject.server }.to output("Starting Mockarron...\n").to_stdout
    end
  end
end
