require 'spec_helper'

RSpec.describe Mockarron::App do
  describe "#new_project" do
    context "when the selected project path does not exist" do
      include_context "clearing_tmp_dir"
      let(:spec_tmp_dir) { "spec/tmp" }

      it "returns a Result with an error flag and message" do
        path = spec_tmp_dir + "/mymock"

        allow(subject)
          .to receive(:path_does_not_exist?)
          .and_return(true)

        allow(subject)
          .to receive(:path_is_not_empty?)
          .and_return(false)

        result = subject.new_project(path)
        expect(result.error?).to be false
      end
    end

    context "when the selected project path is not empty" do
      it "returns a Result with an error flag and message" do
        allow(subject)
          .to receive(:path_does_not_exist?)
          .and_return(false)

        allow(subject)
          .to receive(:path_is_not_empty?)
          .and_return(true)

        result = subject.new_project("/some/path")
        expect(result.error?).to be true
        expect(result.message).to be ""
      end
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
      include_context "using_routes_fixture"

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
    include_context "using_routes_fixture"

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
    include_context "using_routes_fixture"

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
