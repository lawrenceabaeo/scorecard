require 'spec_helper'
require 'helpers/helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'Quick Scorecard' do
  before :each do
    visit root_path
    user = create(:user)
    sign_in(user)
  end

  it 'displays any existing actions a user picked' do 
    pending
  end

  it 'lets user delete any existing action' do 
    pending
  end

  it 'lets user pick any other option not available in the quick score' do 
    pending
  end

end