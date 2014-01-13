require 'spec_helper'

describe Round do
  it "has a valid factory" do
    create(:round).should be_valid
  end
  
  it { should belong_to(:card) }

  it { should validate_presence_of(:round_number)}

end
