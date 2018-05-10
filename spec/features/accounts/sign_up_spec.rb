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

    # click_button "Next"
    #
    account = Account.last
    # expect(account.stripe_customer_id).to be_present
    #
    # choose "Starter"
    #
    # click_button "Pay"

    # within_frame("stripe_checkout_app") do
    #   fill_in "Email", with: "test@example.com"
    #   card_input = find("#card_number").native
    #   fill_in card_input["id"], with: "4242 4242 4242 4242"
    #
    #   expiry = 1.month.from_now
    #   exp_input = find("#cc-exp").native
    #   exp_input.send_keys(expiry.strftime("%m"))
    #   sleep(0.25)
    #   exp_input.send_keys(expiry.strftime("%y"))
    #
    #   csc_input = find("#cc-csc").native
    #   csc_input.send_keys("424")
    #   click_button "submitButton"
    # end


    # success_message = "Your account has been created."
    # expect(page).to have_content(success_message)

    # account.reload
    # expect(account.plan).to eq(plan)
    expect(account.stripe_subscription_id).to be_present
    expect(page.current_url).to eq(root_url)
  end
end
