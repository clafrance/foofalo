# def random_letters
#   letter = (rand(122-97) + 97).chr
#   letter + letter + letter  
# end

def random_letters(n)
  letters = ('a'..'z').to_a.shuffle[0..n].join
end

def sign_in(user)
  visit new_session_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Sign in"
end

def remember_me_sign_in_successfully(user)
  visit new_session_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  check("Remember me")
  click_button "Sign in"
  should have_content('You have successfully signed in!')
  current_path.should eq(index_path)
end

def sign_in_successfully(user)
  visit new_session_path
  fill_in "Username", :with => user.username
  fill_in "Password", :with => user.password
  click_button "Sign in"
  should have_content('You have successfully signed in!')
  current_path.should eq(index_path)
end

def should_have_links_before_signin
  it { should have_link("Sign up") }
  it { should have_link("Sign in") }
  it { should have_link("Home") }
  it { should have_link("About") }
  it { should have_link("Terms") }
end