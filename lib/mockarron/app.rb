require 'mockarron/error'
require 'mockarron/route'

module Mockarron
  class App
    ROUTE_DATA_FILE     = "routes.yaml"
    ROUTE_TEMPLATE_FILE = "routes.template.yaml"
    TEMPLATE_DIR        = "templates"

    def new_project
      unless route_file_exists?
        template_file = File.read(ROUTE_TEMPLATE_FILE)
        File.write(ROUTE_DATA_FILE, template_file)
      end

      unless templates_exists?
        Dir.mkdir(TEMPLATE_DIR)
      end
    end

    def load_route_data
      if route_file_exists?
        route_data = YAML.load_file(ROUTE_DATA_FILE)
        route_data.map { |r| Route.new(r) }
      else
        false
      end

    rescue Errno::ENOENT
      raise Mockarron::Error.new("Cannot open file: #{ROUTE_DATA_FILE}")
    end

    private

      def route_file_exists?
        File.exists? ROUTE_DATA_FILE
      end

      def templates_exists?
        File.directory? TEMPLATE_DIR
      end
  end
end
