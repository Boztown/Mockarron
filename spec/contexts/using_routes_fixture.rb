shared_context "using_routes_fixture", :a => :b do
  # `routes.yaml` doesn't exist, so we'll point it to the template file
  before { stub_const("Mockarron::App::ROUTE_DATA_FILE", "./spec/fixtures/routes.test.yaml") }
end
