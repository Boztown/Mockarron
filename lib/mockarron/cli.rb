require 'thor'
require 'mockarron/web_server'
require 'mockarron/app'
require 'pry'

module Mockarron
  class CLI < Thor
    desc "new", "Creates a new Mockarron project"
    def new
      mockarron = Mockarron::App.new
      mockarron.new_project
    end

    desc "server", "Starts the Mockarron web server"
    def server
      puts "Starting Mockarron..."
      Mockarron::WebServer.run!
    end
  end
end
