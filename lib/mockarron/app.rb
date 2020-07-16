require 'mockarron/error'

module Mockarron
  class App
    ROUTE_DATA_FILE = "routes.yaml"

    def new_project
      unless File.exists? ROUTE_DATA_FILE
        File.write("routes.yaml", "Hi")
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
