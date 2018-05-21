require "rails_helper"

feature "Accounts" do
  let!(:plan) do
    Plan.create!(
      name: "Starter",
      stripe_id: "starter"
    )
  end

  scenario "creating an account" do
    visit root_url
    click_link "sign up"
    fill_in "Name", with: "Test"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Next"

    account = Account.last
    expect(account.stripe_customer_id).to be_present

    # within(".flash_notice") do
    #   success_message = "Your account has been created."
    #   expect(page).to have_content(success_message)
    # end

    account.reload

    # expect(account.stripe_subscription_id).to be_present
    expect(page.current_url).to eq(account_choose_plan_url(account))
    choose "Starter"
    expect(account.plan).to eq(plan)
    expect(page.current_url).to eq(root_url)
  end
end
