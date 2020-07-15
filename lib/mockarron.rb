require 'pry-byebug'
require "mockarron/version"
require 'sinatra'
require 'sinatra/reloader'if settings.environment == :development
require 'yaml'

module Mockarron
  class Error < StandardError; end

  class WebServer < Sinatra::Base
    configure :development do
      # register Sinatra::Reloader
    end
    # $route_defs = YAML.load(File.read("routes.yaml"))
    # $routes = $route_defs.map { |r| Route.new(r) }

    get '/' do
      erb :index
    end
  end
end

