require "mockarron/version"
require 'sinatra'
require 'yaml'

module Mockarron
  class Error < StandardError; end

  class WebServer < Sinatra::Base
    # $route_defs = YAML.load(File.read("routes.yaml"))
    # $routes = $route_defs.map { |r| Route.new(r) }

    get '/' do
      "UI for route selection upcoming."
    end
  end
end

