require "rails_helper"

feature "Inviting users" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:account) { FactoryGirl.create(:account)}

  before do
    login_as(account.owner)
    visit root_url
    visit projects_path
  end

  scenario "invites a user successfully" do
    click_link "Users"
    click_link "Invite user"
    fill_in "Email", with: "text@example.com"
    click_button "Invite User"
    expect(page).to have_content("text@example.com has been invited.")
    expect(page.current_url).to eq(root_url)

    email = find_email("test@example.com")
    # expect(email).to be_present
    # expect(email.subject).to eq("Invitation to join #{account.name} on Yrsa")
  end
end
