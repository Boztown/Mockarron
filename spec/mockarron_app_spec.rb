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
end
