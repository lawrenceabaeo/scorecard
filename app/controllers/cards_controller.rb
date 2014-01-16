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

  def create
    if URI(request.referer).path == '/cards'
      
      # Create a match with only rounds and default figthers
        # NOT sure why there is no match name or  description. Need to put in as featue request. 

      total_rounds = params[:total_rounds]

      # Probably should learn to put this in a constant/yaml
      # Grab system created 'Fighter A' and 'Fighter B' to use as the default fighters. 
      system_user = User.find_by_email("systemdefault@example.com")
      fighter_a = Fighter.where(:user_id => system_user.id).where(:last_name => "A").first
      fighter_b = Fighter.where(:user_id => system_user.id).where(:last_name => "B").first
      match = Match.new
      match = current_user.matches.build(:total_rounds => total_rounds, :redcorner => fighter_a, :bluecorner => fighter_b)
      
      if !(match.save)
        redirect_to scorecards_path, :alert => "There was an error saving the MATCH. Please try again."
      end
      
      # Now create scorecard object and attach the match to it. 

      card = Card.new
      card = current_user.cards.build(:match_id => match.id)

      if (card.save)
        redirect_to card, :notice => "You successfully created a scorecard!"        
      else  
        redirect_to cards_path, :alert => "There was an error saving the SCORECARD. Please try again."
      end
    
    else
      puts "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG "
      puts "WATCH THE PARAMS SENT HERE, for something to key off of!"
      puts "request.referer is: #{request.referer}"
      # Get latest match
      puts "DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG DEBUG "
      redirect_to root_path, :notice => "You successfully created a scorecard! TODO: Show Scorecard"
    end
  end
end
