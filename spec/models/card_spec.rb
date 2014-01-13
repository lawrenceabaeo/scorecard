require 'spec_helper'

describe Card do
  # it "has a valid factory" do
  #   create(:card).should be_valid
  # end
  
  # it { should belong_to(:match) }
  
  # it { should belong_to(:user) }

  # it { should have_many(:rounds) }

  it "does stuff" do 
    red = create(:fighter)
    red.update_attributes(:first_name => "Red")
    
    blue = create(:fighter)
    blue.update_attributes(:first_name => "BLUE")

    mymatch = Match.create(:total_rounds => 12, :redcorner => red, :bluecorner => blue)
    # mymatch.redcorner.first_name.should equal(red.first_name)  
    
    user = create(:user)
    card = Card.create(match: mymatch, user: user)
    totalrounds = card.match.total_rounds

    # Create a round
    round1 = card.rounds.create(round_number: 1)
    
    # Create a new cell
    a_cell_for_round_1 = Cell.create(round: round1)

    # Add the cell to one corner
    round1.update_attributes(redcornercell: a_cell_for_round_1)

    # Dummy Actions:
    poop_action = Action.create(name: "Poopy Action!", points: 3)
    
    pee_action = Action.create(name: "Peeing!", points: -5)

    caca_action = Action.create(name: "Caca!", points: 4)

    event1 = Event.create(cell: a_cell_for_round_1, action: poop_action)

    event2 = Event.create(cell: a_cell_for_round_1, action: pee_action)
    
    # CONVENIENCE ASSIGNMENT!
    round1.redcornercell.events.create(action: caca_action)

    puts "================================================================"
    round1.redcornercell.events.each do |doo|
      puts "printing out the event action name:"
      puts doo.action.name
    end
    puts ""
    puts "================================================================"

    puts "================================================================"
    round_total_points = 0
    round1.redcornercell.events.each do |doo|
      round_total_points += doo.action.points
    end
    puts "total points for the round is: #{round_total_points}"
    puts "================================================================"

    puts "================================================================"
    puts ""
    puts ""
    puts "================================================================"
  end

end
