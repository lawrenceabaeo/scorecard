module Helpers
  def sign_in(user)
    click_on 'Login'
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: "helloworld" # yup, hardcoding this here, I have a delicious bookmark somwhere explaining why
    click_button 'Log in'  
  end
end