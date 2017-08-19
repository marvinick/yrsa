require "rails_helper"

feature "Admin account dashboard" do
  let!(:starter_plan) do
    Plan.create(name: "Starter", amount: 995)
  end

  let!(:account) do
    FactoryGirl.create(:account, :subscribed, plan: starter_plan)
  end

  let!(:subscription_event) do
    account.subscription_events.create(type: "customer.subscription.created")
  end

  before do
    visit root_url
  end

  context "as an admin" do
    let!("admin") do
      FactoryGirl.create(:user, admin: true)
    end

    before do
      login_as(admin)
    end

    scenario "it can find an account by its name" do
      visit admin_root_path
      expect(page).to have_content("Find account by name")
      fill_in "name", with: account.name
      click_button "Search"

      expect(page.current_url).to eq(admin_member_url(account))
      expect(page).to have_content(account.name)
      expect(page).to have_content("Plan: #{starter_plan.name}")

      expect(page).to have_content("customer.subscription.created")
    end
  end

  context "as a user" do
    let!(:user) { FactoryGirl.create(:user)}

    before do
      login_as(user)
    end

    scenario "is unautorized" do
      visit admin_root_path
      expect(page.current_url).to eq(root_url)
      expect(page).to have_content("You are not permitted to access that.")
    end
  end
end
