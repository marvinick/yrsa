require 'rails_helper'

feature 'Subscriptions are required' do
  let!(:account) { FactoryBot.create(:account) }
  context "as an account owner" do
    before do
      login_as(account.owner)

    end

    scenario "Account owner must select a plan" do
      visit root_url
      expect(page).to have_link("sign first")
      # click_link "sign first"
      # expect(page.current_url).to eq(account_choose_plan_url(account))``
      # within(".flash_alert") do
      #   message = "You must subscribe to a plan before you can use your account."
      #   expect(page).to have_content(message)
      # end
    end
  end
end
