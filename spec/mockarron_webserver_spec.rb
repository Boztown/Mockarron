require 'spec_helper'
require "mockarron/web_server"

RSpec.describe Mockarron::WebServer do
  describe "Initialization" do
    context "when there's an issue loading the server" do
      context "because the routes YAML file wasn't loaded" do
        before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "some_file_that_doesnt_exist.yaml") }

        it "displays a message" do
          get '/'
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
