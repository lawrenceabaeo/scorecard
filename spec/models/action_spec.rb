require 'spec_helper'

describe Action do
  it "has a valid factory" do # skipping this for now
    create(:action).should be_valid
  end

  it { should have_many(:rounds) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:points) }

end
