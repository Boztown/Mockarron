require "mockarron/version"
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

module Mockarron
  class Error < StandardError; end

  class WebServer < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end
    # $route_defs = YAML.load(File.read("routes.yaml"))
    # $routes = $route_defs.map { |r| Route.new(r) }

    get '/' do
      "UI for route selection upcoming?"
    end
  end
end

