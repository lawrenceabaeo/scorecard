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

  it 'shows a current score for both boxers, even if fight still has rounds left' do
    pending
  end

  it 'shows a final score for a boxer after all rounds have been scored' do 
    pending
  end

  it 'does NOT show a final score if some rounds still need scoring' do
    pending
  end

  it 'shows a win-by-your-scorecard-points message if there is a final score' do
    pending
  end

  it 'shows a non-points message for fight stoppage like KO' do 
    pending
  end

  it 'in VERSION 2 hides edit options for rounds that occur after a stoppage event' do
    pending
  end

  it 'automatically scores round for Boxer B as a loss if user scores Boxer A winning the round' do 
    pending
  end

  it 'automatically scores round for Boxer B as a win if user scores Boxer A losing the round' do 
    pending
  end

  it 'automatically scores both boxers with 10 if user scores one boxer with a tie' do 
    pending
  end

end