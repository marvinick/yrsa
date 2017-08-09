require "rails_helper"

feature "Accepting invitations" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  let(:account) { FactoryGirl.create(:account) }
  let(:invitation) do
    Invitation.create(
      account: account,
      email: "test@example.com"
    )
  end

  before do
     InvitationMailer.invite(invitation, account).deliver_now
  end

  scenario "accepts as invitation" do
    email = open_email("test@example.com")
    accept_link = links_in_email(email).first
    expect(accept_link).to be_present
    visit accept_link
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Accept Invitation"
    expect(page).to have_content("You have joined the #{account.name} account.")
    expect(page.current_url).to eq(root_url)
  end

  scenario "accepts an invitation as an existing user" do
    email = open_email("test@example.com")
    accept_link = links_in_email(email).first
    expect(accept_link).to be_present

    visit accept_link
    click_link "Sign in as an existing user"
    user = FactoryGirl.create(:user)
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    invitation_url = accept_account_invitation_url(account, invitation)
    expect(page.current_url).to eq(invitation_url)
    expect(page).to_not have_content("Sign in as an existing user")
    click_button "Accept Invitation"
    expect(page).to have_content("You have joined the #{account.name} account.")
    expect(page.current_url).to eq(root_url)
  end
end
