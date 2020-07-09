require "mockarron/version"
require 'sinatra'

module Mockarron
  class Error < StandardError; end

  class WebServer < Sinatra::Base
    get '/' do
      "I started this gangsta shit."
    end
  end

  def self.run
    puts "something."
  end
end

