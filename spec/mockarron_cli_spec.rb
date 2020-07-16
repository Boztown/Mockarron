require 'spec_helper'
require "mockarron/cli"

RSpec.describe Mockarron::CLI do
  describe "Command: new" do
    context "when the chosen directory is not empty" do
      it "returns an error, and does not create any files" do
        dirname = "mymockarron"
        Dir.mkdir(dirname)
        File.write("#{dirname}/something.txt", "here")
        result = subject.new
        expect(result.error?).to be true
        expect(File.exists?("#{dirname}/#{Mockarron::App::ROUTE_DATA_FILE}")).to be false
        FileUtils.remove_dir(dirname, true)
      end
    end

    context "when there is no existing 'routes.yaml' file" do
      before do
        allow_any_instance_of(Mockarron::App)
          .to receive(:route_file_exists?)
          .and_return(false)
      end

      it "should create a 'routes.yaml' file based on the template" do
        template_file = File.read(Mockarron::App::ROUTE_TEMPLATE_FILE)
        expect(File).to receive(:write).with("routes.yaml", template_file)
        subject.new
      end
    end

    context "when there is no existing 'templates' directory" do
      before do
        allow_any_instance_of(Mockarron::App)
          .to receive(:templates_exists?)
          .and_return(false)
      end

      it "should create a 'templates' directory" do
        expect(Dir).to receive(:mkdir).with(Mockarron::App::TEMPLATE_DIR)
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
