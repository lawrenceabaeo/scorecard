class CardsController < ApplicationController

  before_filter :authenticate_user!

  def index
    
  end

  def show
    @card = Card.find(params[:id])
    @total_rounds = @card.match.total_rounds
    @red_corner_name = @card.match.redcorner.first_name + " " + @card.match.redcorner.last_name
    @blue_corner_name = @card.match.bluecorner.first_name + " " + @card.match.bluecorner.last_name
  end

  def new
  end

  def edit
  end

  def quick_create
    # Match params
    total_rounds = params[:total_rounds]
    system_user = User.find_by_email(YAML_CONFIG['system_user']['email'])
    fighter_a = Fighter.where(:user_id => system_user.id).where(:last_name => "A").first
    fighter_b = Fighter.where(:user_id => system_user.id).where(:last_name => "B").first
    
    match = Match.new
    match = current_user.matches.build(:total_rounds => total_rounds, :redcorner => fighter_a, :bluecorner => fighter_b)
    if !(match.save)
      redirect_to scorecards_path, :alert => "There was an error when saving. Please try again."
    end
    
    #Now create card with that new match object
    card = Card.new
    card = current_user.cards.build(:match_id => match.id)
    if (card.save)
      redirect_to card, :notice => "You successfully created a scorecard!"        
    else  
      redirect_to cards_path, :alert => "There was an error saving the SCORECARD. Please try again."
    end
  end

  def create
  end

end
