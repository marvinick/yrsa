require "rails_helper"

feature "Inviting users" do
  let(:account) { FactoryGirl.create(:account)}

  before do
    login_as(account.owner)
    visit root_url
  end

  scenario "invites a user successfully" do
    click_link "Invite user"
    fill_in "Email", with: "text@example.com"
    click_button "Invite User"
    expect(page).to have_content("text@example.com has been invited.")
    expect(page.current_url).to eq(root_url)
  end
end
