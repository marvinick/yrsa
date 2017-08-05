require "rails_helper"

feature "Accounts" do
  scenario "creating an account" do
    visit root_url
    click_link "Create a new account"
    fill_in "Name", with: "Test"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Create Account"

    success_message = "Your account has been created."
    expect(page).to have_content(success_message)
  end
end
