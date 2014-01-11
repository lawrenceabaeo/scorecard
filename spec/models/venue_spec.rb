require 'spec_helper'

describe Venue do
  it "has a valid factory" do # skipping this for now
    create(:venue).should be_valid
  end

  it { should have_many(:matches) }

end
