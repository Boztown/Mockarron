require 'spec_helper'

RSpec.describe Mockarron::App do
  describe "#new_project" do
    xcontext "when the selected project path is not empty" do
    end
  end

  describe "#load_route_data" do
    context "when the routes YAML file isn't where it should be" do
      before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "some_file_that_doesnt_exist.yaml") }

      it "falls back to loading routes.template.yaml" do
        expect(YAML).to receive(:load_file)
          .with(Mockarron::App::ROUTE_TEMPLATE_FILE)
          .and_call_original

        subject.load_route_data
      end
    end

    context "when the routes YAML file is available" do
      # `routes.yaml` doesn't exist, so we'll point it to the template file
      before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "routes.template.yaml") }

      it "loads up and parses the file" do
        expect(YAML).to receive(:load_file)
          .with(Mockarron::App::ROUTE_DATA_FILE)
          .and_call_original

        routes = subject.load_route_data
        expect(routes).to be_a Array
        expect(routes.first).to be_a Mockarron::Route
        expect(routes.first.responses.first).to be_a Mockarron::RouteResponse
      end
    end
  end

  describe "#find_route_response_by_id" do
    # `routes.yaml` doesn't exist, so we'll point it to the template file
    before do
      stub_const("Mockarron::App::ROUTE_DATA_FILE", "routes.template.yaml")
    end

    let!(:routes) { subject.load_route_data }

    context "when the supplied ID is found in the route data" do
      it "returns a Mockarron::RouteResponse" do
        id = routes.first.responses.first.id
        route_response = subject.find_route_response_by_id(id)
        expect(route_response).to be_a Mockarron::RouteResponse
        expect(route_response.id).to eq id
      end
    end

    context "when the supplied ID is NOT found in the route data" do
      it "returns `nil`" do
        id = "non-existent-id"
        route_response = subject.find_route_response_by_id(id)
        expect(route_response).to be_nil
      end
    end
  end

  describe "#select_route_response_by_id" do
    # `routes.yaml` doesn't exist, so we'll point it to the template file
    before do
      stub_const("Mockarron::App::ROUTE_DATA_FILE", "routes.template.yaml")
    end

    let!(:routes) { subject.load_route_data }

    context "when the supplied ID is found in the route data" do
      it "returns a Mockarron::RouteResponse" do
        id = routes.first.responses.first.id
        route_response = subject.select_route_response_by_id(id)
        expect(route_response).to be_a Mockarron::RouteResponse
        expect(route_response.id).to eq id
      end

      it "marks Mockarron::RouteResponse as 'selected'" do
        id = routes.first.responses.first.id
        route_response = subject.select_route_response_by_id(id)
        expect(route_response.selected).to be true
      end
    end
  end
end
