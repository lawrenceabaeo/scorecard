require 'spec_helper'
# Example model tests:
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe Match do
  it "has a valid factory" do # skipping this for now
    create(:match).should be_valid
  end
  
  it { should belong_to(:venue) }

  it { should have_many(:cards) }

  it { should belong_to(:user)}

  it { should validate_presence_of(:total_rounds)}

  it "returns first name from redcorner association" do 
    red = create(:fighter)
    red.update_attributes(:first_name => "Red")
    
    blue = create(:fighter)
    blue.update_attributes(:first_name => "BLUE")

    mymatch = Match.create(:total_rounds => 12, :redcorner => red, :bluecorner => blue)
    mymatch.redcorner.first_name.should equal(red.first_name)
  end

end
