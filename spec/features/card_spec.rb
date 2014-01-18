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

  it 'lets user select round numbers to create card' do 
    click_on "Cards"
    select '12', from: 'total_rounds'
    click_button "Create"
    page.should have_content "You successfully created a scorecard!"
    page.should have_content "12"
  end

  it 'lets user edit cell using Edit link' do 
    # need to use factory to create a card
    click_on "Cards"
    select '12', from: 'total_rounds'
    click_button "Create"
    # crap, now need to direct test to a specific edit link
    # then click an action
    # then verify the result
  end





end