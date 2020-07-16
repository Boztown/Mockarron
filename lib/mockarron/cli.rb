require 'thor'
require 'mockarron/web_server'

module Mockarron
  class CLI < Thor
    desc "server", "Starts the Mockarron web server"
    def server
      puts "Starting Mockarron..."
      Mockarron::WebServer.run!
    end
  end
end
