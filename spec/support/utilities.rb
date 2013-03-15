# def random_letters
#   letter = (rand(122-97) + 97).chr
#   letter + letter + letter  
# end

def random_letters(n)
  letters = ('a'..'z').to_a.shuffle[0..n].join
end

def sign_in(user)
  # signed in as non admin user
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

def should_have_items_before_signin
  should have_link("Sign up")
  should have_link("Sign in")
  should have_link("Home")
  should have_link("HOME")
  should have_link("ABOUT")
  should have_link("TERMS")
  should have_selector("img[src$='/assets/logo60.png']")
  should have_content("COPYRIGHT @ 2011 FOOFALO.COM ALL RIGHTS RESERVED")
end

def should_have_items_after_signin
  should have_link("Sign out")
  should have_link("Home")
  should have_link("Users")
  should have_link("Profile")
  should have_link("Jokes")
  should have_link("Challenges")
  should have_link("Fun Facts")
  should have_link("Games")
  should have_link("Manster Cards")
  should have_link("HOME")
  should have_link("ABOUT")
  should have_link("TERMS")
  should have_selector("img[src$='/assets/logo30.png']")
  should have_content("COPYRIGHT @ 2011 FOOFALO.COM ALL RIGHTS RESERVED")
end

def sign_in_user
  user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49", :privilege => "user")
  displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
  displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
  displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
  displayed_link = Factory(:link, :user_id => user.id)
  display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
  display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
  display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
  sign_in_successfully(user)
  should_have_items_after_signin
end

def sign_in_admin_user
  user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49", :privilege => "admin")
  displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
  displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
  displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
  displayed_link = Factory(:link, :user_id => user.id)
  display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
  display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
  display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
  sign_in_successfully(user)
  should_have_items_after_signin
end

def should_have_joke_links_for_user
  should have_link("Enter New Jokes")
  should have_link("View, Edit My Jokes")
  should have_link("Displayed Jokes")
  should have_link("Jokes by Authors")
end

def should_have_joke_links_for_admin
  should have_link("Enter New Jokes")
  should have_link("View, Edit My Jokes")
  should have_link("Displayed Jokes")
  should have_link("Manage Jokes")
  should have_link("Jokes by Authors")
end

def should_have_challenge_links_for_user
  should have_link("View Challenges")
end

def should_have_challenge_links_for_admin
  should have_link("Enter New Challenge")
  should have_link("View, Edit Challenges")
end