require 'mockarron/error'

module Mockarron
  class App
    ROUTE_DATA_FILE     = "routes.yaml"
    ROUTE_TEMPLATE_FILE = "routes.template.yaml"

    def new_project
      unless File.exists? ROUTE_DATA_FILE
        template_file = File.read(ROUTE_TEMPLATE_FILE)
        File.write(ROUTE_DATA_FILE, template_file)
      end
    end

    def load_route_data
      if File.exists? ROUTE_DATA_FILE
        route_data = YAML.load_file(ROUTE_DATA_FILE)
        route_data.map { |r| Route.new(r) }
      else
        false
      end

    rescue Errno::ENOENT
      raise Mockarron::Error.new("Cannot open file: #{ROUTE_DATA_FILE}")
    end
  end
end
