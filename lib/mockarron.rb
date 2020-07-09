require "mockarron/version"
require 'sinatra'

module Mockarron
  class Error < StandardError; end

  def self.run
    puts "something."
  end
end
