require "rails_helper"

feature "Subscriptions are required" do
  let!(:account) { FactoryGirl.create(:account) }

  context "as an account owner" do
    before do
      login_as(account.owner)
    end

    scenario "account owner must select a plan" do
      expect(page.current_url).to eq(w)
