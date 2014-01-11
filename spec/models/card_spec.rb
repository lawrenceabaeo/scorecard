require 'spec_helper'

describe Card do
  it "has a valid factory" do
    create(:card).should be_valid
  end
  
  it { should belong_to(:match) }
  
  it { should belong_to(:user) }

  it { should have_many(:rounds) }
end
