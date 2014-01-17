class CardsController < ApplicationController

  before_filter :authenticate_user!

  def index
    
  end

  def show
    @card = Card.find(params[:id])
    @rounds = Round.where(:card => @card).order(round_number: :asc )
    @red_corner_name = @card.match.redcorner.first_name + " " + @card.match.redcorner.last_name
    @blue_corner_name = @card.match.bluecorner.first_name + " " + @card.match.bluecorner.last_name
  end

  def new
  end

  def edit
  end

  def quick_create
    quick_match = create_quick_match  
    card = Card.new
    card = current_user.cards.build(:match => quick_match)
    if (card.save)
      create_rounds_and_cells(card)
      redirect_to card, :notice => "You successfully created a scorecard!"
    else  
      redirect_to cards_path, :alert => "There was an error saving the SCORECARD. Please try again."
    end
  end

  def create
  end

  private #====================================================================================
  
  def create_quick_match
    # Match params
    total_rounds = params[:total_rounds] || 1 # in case params got messed up, which they shouldn't
    system_user = User.find_by_email(YAML_CONFIG['system_user']['email'])
    fighter_a = Fighter.where(:user => system_user).where(:last_name => YAML_CONFIG['fighter_a']['last_name']).first
    fighter_b = Fighter.where(:user => system_user).where(:last_name => YAML_CONFIG['fighter_b']['last_name']).first
    
    match = Match.new
    match = current_user.matches.build(:total_rounds => total_rounds, :redcorner => fighter_a, :bluecorner => fighter_b)
    if !(match.save)
      redirect_to scorecards_path, :alert => "There was an error when saving. Please try again."
    end
    return match
  end

  def create_rounds_and_cells(card)
    card.match.total_rounds.times do |round|
      this_round = card.rounds.create(:round_number => round + 1)
      this_round.update_attributes(
        redcornercell: Cell.create(round: this_round), 
        bluecornercell: Cell.create(round: this_round) )
    end
  end

end
