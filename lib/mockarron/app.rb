require 'mockarron/error'
require 'mockarron/route'
require 'mockarron/result'

module Mockarron
  class App
    ROUTE_DATA_FILE     = "routes.yaml"
    ROUTE_TEMPLATE_FILE = "routes.template.yaml"
    TEMPLATE_DIR        = "templates"

    def new_project(path = ".")
      if path_does_not_exist?(path)
        Dir.mkdir(path)
      end

      if path_is_not_empty?(path)
        return Result.new(
          error: true,
          message: "Directory is not empty!"
        )
      end

      template_file = File.read(ROUTE_TEMPLATE_FILE)
      puts "Creating `#{ROUTE_DATA_FILE}` file"
      File.write(path + "/" + ROUTE_DATA_FILE, template_file)

      puts "Creating `/#{TEMPLATE_DIR}` directory"
      Dir.mkdir(path + "/" + TEMPLATE_DIR)

      return Result.new(
        error: false,
        message: "Project successfully initialized"
      )
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

      def route_file_exists?(path = ".")
        File.exists? path + "/" + ROUTE_DATA_FILE
      end

      def templates_exists?(path = ".")
        File.directory? path + "/" + TEMPLATE_DIR
      end

      def path_is_not_empty?(path = ".")
        !(Dir.empty?(path))
      end

      def path_does_not_exist?(path)
        !(Dir.exists?(path))
      end
  end
end
