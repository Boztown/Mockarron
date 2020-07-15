require 'sinatra/base'
require 'yaml'
require "mockarron/app"
require "mockarron/error"

module Mockarron
  class WebServer < Sinatra::Base
    set :views, "#{settings.root}/../views"
    set :public_folder, "#{settings.root}/../public"

    configure do
      app = Mockarron::App.new
      $routes = app.load_route_data
    rescue Mockarron::Error
      $routes = []
    end

    get '/' do
      @routes = $routes
      erb :index
    end
  end
end
