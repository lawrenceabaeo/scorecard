require 'spec_helper'
# Example model tests:
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end
end
