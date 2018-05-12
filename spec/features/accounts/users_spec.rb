require "rails_helper"

feature "Users" do
  let(:account) { FactoryBot.create(:account)}
  let(:user) { FactoryBot.create(:user) }

  before do
    account.users << user
  end

  context "as an account owner" do
    before { login_as(account.owner)}

    scenario "it can remove a user" do
      visit root_url
      visit accounts_path
      click_link "Users"
      expect(page).to have_content(account.owner.email)
      expect(page).to have_content(user.email)

      click_link "Remove"

      expect(page).to have_content("#{user.email} has been removed from this account.")
      expect(account.reload.users).to be_empty
    end
  end

  context "as an account user" do
    before { login_as(user) }

    scenario "it does not see the users link" do
      visit root_url
      visit accounts_path
      expect { find_link("Users") }.to raise_error(Capybara::ElementNotFound)
    end

    scenario "cannot go to the users page" do
      visit root_url
      visit accounts_path
      visit account_project_path
      visit account_project_users_path
      expect(page).to have_content("Only an owner of the account can do that.")
    end
  end
end
