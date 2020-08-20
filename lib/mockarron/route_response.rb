module Mockarron

  # Does a thing
  # @since 0.8.0
  class RouteResponse
    attr_reader :id, :file, :route
    attr_accessor :selected

    def initialize(response_def, parent)
      @id       = SecureRandom.uuid
      @code     = response_def["code"]
      @file     = response_def["file"]
      @selected = response_def["selected"] || false
      @route    = parent
    end

    def code
      @code.to_i
    end
  end
end
