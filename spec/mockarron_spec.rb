require 'spec_helper'


RSpec.describe Mockarron do
  it "has a version number" do
    expect(Mockarron::VERSION).not_to be nil
  end
end

RSpec.describe Mockarron::App do
  describe "#load_route_data" do
    context "when the routes YAML file isn't where it should be" do
      before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "some_file_that_doesnt_exist.yaml") }

      it "raises a Mockarron error, with a helpful message" do
        expect {
          subject.load_route_data
        }.to raise_error(Mockarron::Error, /Cannot open/)
      end
    end

    context "when" do

    end
  end
end

RSpec.describe Mockarron::WebServer do
  describe "Initialization" do
    context "when there's an issue loading the server" do
      context "because the routes YAML file wasn't loaded" do
        before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "some_file_that_doesnt_exist.yaml") }

        it "displays a message" do
          get '/'
          binding.pry
          expect(last_response).to be_ok
        end
      end
    end
  end

  describe "Path: /" do
    it "returns a successful response" do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
