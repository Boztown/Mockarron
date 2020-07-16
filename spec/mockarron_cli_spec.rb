require 'spec_helper'
require "mockarron/cli"

RSpec.describe Mockarron::CLI do
  describe "Command: new" do
    context "when there is no existing 'routes.yaml' file" do
      before { allow(File).to receive(:exists?).and_return(false) }

      it "should create a 'routes.yaml' file based on the template" do
        template_file = File.read(Mockarron::App::ROUTE_TEMPLATE_FILE)
        expect(File).to receive(:write).with("routes.yaml", template_file)
        subject.new
      end
    end
  end

  describe "Command: server" do
    it "is expected to start the web server and output a message" do
      expect(Mockarron::WebServer).to receive(:run!).and_return(true)
      expect { subject.server }.to output("Starting Mockarron...\n").to_stdout
    end
  end
end
