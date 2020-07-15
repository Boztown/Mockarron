module Mockarron
  class Route
    attr_reader :uri, :params, :responses

    def initialize(route_def)
      @uri       = route_def[0]
      @method    = route_def[1]["method"]
      @params    = route_def[1]["params"]
      @responses = build_responses(route_def[1]["responses"])
    end

    def method
      @method.to_sym
    end

    private

    def build_responses(responses)
      responses.map do |r|
        RouteResponse.new(r, self)
      end
    end
  end
end
