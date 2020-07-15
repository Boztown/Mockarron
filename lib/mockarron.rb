require 'pry-byebug'
require "mockarron/version"
require 'sinatra/base'
# require 'sinatra/reloader'if settings.environment == :development
require 'yaml'

module Mockarron
  class Error < StandardError; end

  class App
    ROUTE_DATA_FILE = "routes.yaml"

    def thing
      binding.pry
    end

    def load_route_data
      route_data = YAML.load(File.read(ROUTE_DATA_FILE))
      route_data.map { |r| "a" }

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
end

