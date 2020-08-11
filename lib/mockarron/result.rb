module Mockarron
  class Result
    attr_accessor :error, :message, :data

    def initialize(error: false, message: nil, data: nil)
      @error = error
      @message = message
      @data = data
    end

    def error?
      @error == true
    end
  end
end
