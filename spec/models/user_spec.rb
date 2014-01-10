require 'spec_helper'
# Example model tests:
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end
  it "is invalid without an email" do 
    build(:user, email: nil).should_not be_valid
  end
  it "is invalid without a password" do 
    build(:user, password: nil).should_not be_valid
  end
  it "is invalid when password doesn't match password confirmation" do 
    build(:user, password: "pooppoop").should_not be_valid
  end
  # NOTE: can't test password_confirmation as it's not really part of the model, but part of the controller
  # it "is invalid without a password confirmation value" do 
  #   build(:user, password_confirmation: nil).should_not be_valid 
  # end

end
