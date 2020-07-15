require 'spec_helper'

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
