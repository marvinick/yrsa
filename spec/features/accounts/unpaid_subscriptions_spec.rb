require "rails_helper"

RSpec.feature "Unpaid subscriptions" do
  let(:account) do
    FactoryGirl.create(:account, :subscribed, stripe_subscription_status: "unpaid")
  end

  let(:project) { FactoryGirl.create(:project) }

  context "a user for the account" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      account.projects << project
      account.users << user
      login_as(user)
    end

    it "cannot access the account's projects" do
      visit account_project_path(account, project)
      expect(page.current_url).to eq(root_url)
      expect(page).to have_content("This account is currently disabled due to an unpaid subscription.")
      expect(page).to have_content("Please contact the account owner.")
    end
  end

  context "the owner of the account" do
    before do
      account.projects << project
      login_as(account.owner)
    end

    it "cannot add a new project to the account" do
      visit new_account_project_path(account, project)
      expect(page.current_url).to eq(root_url)
      expect(page).to have_content("This account is currently disabled due to an unpaid subscription.")
      expect(page).to have_content("Please update your payment details to re-activate your subscription.")
    end
  end
end
