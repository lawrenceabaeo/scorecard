require 'spec_helper'

describe Fighter do
  it "has a valid factory" do
    create(:fighter).should be_valid
  end
  
  it { should belong_to(:user) }

end
