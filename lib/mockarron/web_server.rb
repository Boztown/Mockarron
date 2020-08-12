require 'sinatra/base'
require 'yaml'
require "mockarron/app"
require "mockarron/error"

module Mockarron
  class WebServer < Sinatra::Base
    set :app, Mockarron::App.new
    set :views, "#{settings.root}/../views"
    set :public_folder, "#{settings.root}/../public"

    configure do
      settings.app.load_route_data
    end

    get '/' do
      @routes = settings.app.routes
      erb :index
    end

    get "/show/:id" do
      @route_response = settings.app.find_route_response_by_id(params["id"])
      erb :show
    end
  end
end
