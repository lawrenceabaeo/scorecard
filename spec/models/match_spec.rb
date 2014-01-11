require 'spec_helper'
# Example model tests:
# http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

describe Match do
  it "has a valid factory" do # skipping this for now
    pending
    create(:match).should be_valid
  end
  
  it { should belong_to(:venue) }
  
  it { should validate_presence_of(:fighter_a) }

  it { should validate_presence_of(:fighter_b) }

  it { should have_many(:cards) }

  it { should belong_to(:user)}

  it { should validate_presence_of(:total_rounds)}

end
