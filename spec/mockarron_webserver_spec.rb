require 'spec_helper'
require "mockarron/web_server"

RSpec.describe Mockarron::WebServer do
  describe "Initialization" do
    context "when there's an issue loading the server" do
      context "because the routes YAML file wasn't loaded" do
        before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "some_file_that_doesnt_exist.yaml") }

        it "displays a message" do
          # expect(Mockarron::App::ROUTE_DATA_FILE).to eq "some_file_that_doesnt_exist.yaml"
          get '/'
          expect(last_response).to be_ok
        end
      end
    end
  end

  describe "GET: /" do
    context "when the sun is shining" do
      it "is expected to return a 200" do
        get '/'
        expect(last_response.status).to eq 200
      end
    end
  end

  describe "GET: /show/:id" do
    context "when the supplied ID exists" do
      it "is expected to return a 200" do
        routes   = subject.settings.app.routes
        route_id = routes.first.responses.first.id
        get "/show/#{route_id}"
        expect(last_response.status).to eq 200
      end
    end

    context "when the supplied ID does not exist" do
      it "is expected to return a 404" do
        route_id = "dingdong"
        get "/show/#{route_id}"
        expect(last_response.status).to eq 404
      end
    end
  end

  describe "POST: /select/:id" do
    it do
      routes   = subject.settings.app.routes
      route_id = routes.first.responses.first.id
      post "/select/#{route_id}"
      expect(last_response.status).to eq 302
    end
  end
end
