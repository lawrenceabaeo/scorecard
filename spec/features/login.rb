require 'spec_helper'
require 'helpers/helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'Edit User Profile' do
  before :each do
    visit root_path
  end

  it 'lets user sign in' do 
    user = create(:user)
    sign_in(user)
    page.should have_content("Signed in successfully.")
  end

  xit 'displays error for invalid password' do 
  end

  xit 'displays error for invalid email' do 
  end

  xit 'displays error for blank email' do 
    # validate on 'Blank word?'
  end

  xit 'displays error for blank username' do 
    # validate on 'Blank word?'
  end

end