require 'spec_helper'
require "mockarron/web_server"

RSpec.describe Mockarron::WebServer do
  describe "Initialization" do
    context "when there's an issue loading the server" do
      context "because the routes YAML file wasn't loaded" do
        it "displays a message" do
          allow_any_instance_of(Mockarron::App)
            .to receive(:routes)
            .and_return(nil)

          get '/'
          expect(last_response.status).to eq 204
        end
      end
    end

    context "when successful" do
      it "creates routes dynamically based on `routes.yaml`" do
        # The `configure` block in Mockarron::WebServer runs immediately as
        # due to the constant `Mockarron::WebServer` being defined at the top
        # of this spec file.
        #
        # When it initializes it will immediately try to load route data.
        # Here we'll make it load the test fixture instead.
        route_data = YAML.load_file("./spec/fixtures/routes.test.yaml")
        routes = route_data.map { |r| Mockarron::Route.new(r) }

        allow_any_instance_of(Mockarron::App)
          .to receive(:load_route_data)
          .and_return(routes)

        # This freak is comparing the route data we have loaded with
        # what Sinatra has initialized as actual routes.
        count = 0
        routes.each do |route|
          subject.helpers.class.routes.each do |r|
            next if r[0] == "HEAD"
            r[1].each do |m|
              if m[0].to_s == route.uri
                count += 1
              end
            end
          end
        end

        expect(count).to eq routes.length
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
    context "when successful" do
      it "redirects" do
        routes   = subject.settings.app.routes
        route_id = routes.first.responses.first.id
        post "/select/#{route_id}"
        expect(last_response.status).to eq 302
      end

      it "marks the chosen route as 'selected'" do
        routes         = subject.settings.app.routes
        route_response = routes.first.responses[1]
        expect(route_response.selected).to be false
        post "/select/#{route_response.id}"
        expect(route_response.selected).to be true
      end
    end
  end
end
