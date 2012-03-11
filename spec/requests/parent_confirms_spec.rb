require 'spec_helper'

describe "ParentsConfirms" do
  it "updates the parent_approved and parent_approved_at" do
    user = Factory(:user, :inform_parents_token => "something", 
            :inform_parents_sent_at => 1.hour.ago)
    visit edit_parent_confirm_url(user.inform_parents_token)
    current_path.should eq(root_path)
    page.should have_content("Thanks for approving")
    last_email.to.should include(user.email)
  end
end