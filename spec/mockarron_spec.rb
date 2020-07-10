require 'spec_helper'

RSpec.describe Mockarron do
  it "has a version number" do
    expect(Mockarron::VERSION).not_to be nil
  end
end

RSpec.describe Mockarron::WebServer do
  it "does something useful" do
    get '/'
    # Rspec 2.x
    expect(last_response).to be_ok
  end
end
