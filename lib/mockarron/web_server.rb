require 'sinatra/base'
require 'yaml'
require "mockarron/app"
require "mockarron/error"
require 'pry'
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
      halt 204 unless @routes
      erb :index
    end

    get "/show/:id" do
      @route_response = settings.app.find_route_response_by_id(params["id"])
      halt 404 unless @route_response
      erb :show
    end

    post "/select/:id" do
      settings.app.select_route_response_by_id(params["id"])
      redirect to "/"
    end

    not_found do
      'This is nowhere to be found.'
    end

    #####################
    settings.app.routes.each do |route|
      send(route.method, route.uri) do
        responses = []

        if params.any?
          settings.app.routes.each do |r|
            if r.params
              if (r.params.to_a - params.to_a).empty?
                # They match params, so the response options become that of this route
                responses = r.responses
              end
            end
          end
        else
          settings.app.routes.each do |r|
            if r.uri == route.uri
              responses = r.responses
            end
          end
        end

        responses.each_with_index do |resp, index|
          if resp.selected
            return [resp.code, {}, read_file(resp.file)]
          end
        end

        [404, {}, "No file found!"]
      end
    end

    def read_file(filepath)
      File.read("templates/#{filepath}")
    end
  end
end
