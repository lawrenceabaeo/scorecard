class FightersController < ApplicationController
  def edit
    fighter = Fighter.find(params[:id])
    @first_name = fighter.first_name
    @last_name = fighter.last_name
    @card_id = params[:card]
  end
  def update
  end
  def edit_fighter
    card_id = params[:card]
    fighter = Fighter.find(params[:id])

    if (card_id == "" || card_id.nil?)
      if current_user != fighter.user
        redirect_to cards_path, :alert => "You cannot update this boxer because it is owned by someone else!"
        return
      else 
        fighter.update_attributes(:first_name => params[:first_name], :last_name => params[:last_name])
        redirect_to cards_path, :notice => "Your boxer was updated!"
        return  
      end
    end

    puts "fighter.id is: #{fighter.id}"
    card = Card.find(card_id)
    if card.match.redcorner_id == fighter.id
      corner = "red"
    else
      corner = "blue"
    end

    if current_user != fighter.user
      puts "This user doesn't own the current fighter, so make a new one"
      new_fighter = Fighter.create(:user_id => current_user.id, :first_name => params[:first_name], :last_name => params[:last_name])
      puts "the new fighter id is: #{new_fighter.id}"
      if corner == "red"
        puts "going to update the red corner"
        card.match.update_attributes(:redcorner_id => new_fighter.id)
      else
        puts "going to update the blue corner"
        card.match.update_attributes(:bluecorner_id => new_fighter.id)
      end
    else 
      puts "It looks like the user owns this fighter. "
      fighter.update_attributes(:first_name => params[:first_name], :last_name => params[:last_name])
    end

    if (card_id.nil? == false && card_id != "")
      redirect_to card_path(card_id), :notice => "Your boxer was updated!"
    else
      redirect_to cards_path, :notice => "Your boxer was updated!"
    end
  end
end
