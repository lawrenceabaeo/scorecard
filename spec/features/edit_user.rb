require 'spec_helper'
require 'helpers/helper'

RSpec.configure do |c|
  c.include Helpers
end

describe 'Edit User Profile' do
  before :each do
    visit root_path
  end

  it 'lets user update name' do 
    new_name = "Doo Doo Brown"
    user = create(:user)
    sign_in(user)
    click_on "Edit account"
    fill_in "Name", with: new_name
    fill_in "Current password", with: user.password
    click_on "Update"
    page.should have_content "You updated your account successfully."
    click_on "Edit account"
    expect(page).to have_field("user_name", with: new_name)
  end

  xit 'displays the users email prefilled in email input field' do 
  end

  xit 'displays error for blank current password' do
  end

  xit 'displays error for mismatch password and password confirmation' do 
  end

  xit 'displays error for invalid current password' do
  end

end