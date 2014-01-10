require 'spec_helper'
# Example model tests:
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe Match do
  it "has a valid factory" do
    create(:match).should be_valid
  end
  
  xit "belongs to one venue" do 
    # Design: Need to setup a default 'blank' venue as an entry so user doesn't have to create a venue
    # Will likely require a seed file
  end
  
  xit "must have athlete A" do 
  end

  xit "must have athlete B" do 
  end

  xit "has many scorecards" do
  end

  xit "belongs to one auther (some user)" do 
  end

  xit "requires total_rounds" do 
  end

end
