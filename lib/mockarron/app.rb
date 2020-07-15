require 'mockarron/error'

module Mockarron
  class App
    ROUTE_DATA_FILE = "routes.yaml"

    def load_route_data
      route_data = YAML.load(File.read(ROUTE_DATA_FILE))
      route_data.map { |r| Route.new(r) }

    rescue Errno::ENOENT
      raise Mockarron::Error.new("Cannot open file: #{ROUTE_DATA_FILE}")
    end
  end
end
