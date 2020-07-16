require 'spec_helper'
require "mockarron/cli"

RSpec.describe Mockarron::CLI do

  let(:spec_tmp_dir)    { "spec/tmp" }
  let(:route_file_path) { "#{spec_tmp_dir}/#{Mockarron::App::ROUTE_DATA_FILE}" }

  before do
    @original_puts = $stdout.method(:puts)
    allow($stdout).to receive(:puts) do |arg|
      @original_puts.call("OUTPUT: #{arg}")
    end
    FileUtils.remove_dir(spec_tmp_dir, true)
    Dir.mkdir(spec_tmp_dir)
  end

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
        expect(File).to receive(:write).with(route_file_path, template_file)
        subject.new(spec_tmp_dir)
      end
    end

    context "when there is no existing 'templates' directory" do
      before do
        allow_any_instance_of(Mockarron::App)
          .to receive(:templates_exists?)
          .and_return(false)
      end

      it "should create a 'templates' directory" do
        expect(Dir).to receive(:mkdir).with("#{spec_tmp_dir}/#{Mockarron::App::TEMPLATE_DIR}")
        subject.new(spec_tmp_dir)
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
