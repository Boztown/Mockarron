require 'pry-byebug'
require "mockarron/version"
require 'sinatra/base'
# require 'sinatra/reloader'if settings.environment == :development
require 'yaml'

module Mockarron
  class Error < StandardError; end

  class App
    ROUTE_DATA_FILE = "routes.yaml"

    def load_route_data
      route_data = YAML.load(File.read(ROUTE_DATA_FILE))
      route_data.map { |r| Route.new(r) }

    rescue Errno::ENOENT => e
      raise Mockarron::Error.new("Cannot open file: #{ROUTE_DATA_FILE}")
    end
  end

  class WebServer < Sinatra::Base
    configure do
      app = Mockarron::App.new
      $routes = app.load_route_data
    rescue Mockarron::Error => e
      $routes = []
    end

    get '/' do
      @routes = $routes
      erb :index
    end
  end

  class Route
    attr_reader :uri, :params, :responses

    def initialize(route_def)
      @uri       = route_def[0]
      @method    = route_def[1]["method"]
      @params    = route_def[1]["params"]
      @responses = build_responses(route_def[1]["responses"])
    end

    def method
      @method.to_sym
    end

    private

    def build_responses(responses)
      responses.map do |r|
        RouteResponse.new(r, self)
      end
    end
  end

  class RouteResponse
    attr_reader :id, :file, :route
    attr_accessor :selected

    def initialize(response_def, parent)
      @id       = SecureRandom.uuid
      @code     = response_def["code"]
      @file     = response_def["file"]
      @selected = response_def["selected"]
      @route    = parent
    end

    def code
      @code.to_i
    end
  end
end

