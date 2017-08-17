require "rails_helper"

feature "Subscriptions" do
  let(:customer) do
    Stripe::Customer.create(
      source: {
        object: "card",
        number: "4242" * 4,
        exp_month: Time.now.month,
        exp_year: Time.now.year + 1,
        cvc: "123"
      }
    )
  end

  let(:plan) { Plan.create(name: "starter", stripe_id: "starter")}
  let(:account) { FactoryGirl.create(:account) }

  before do
    subscription = customer.subscriptions.create(plan: "starter")
    account.stripe_customer_id = customer.id
    account.stripe_subscription_id = subscription.id
    account.save

    login_as(account.owner)
  end

  scenario "can be cancelled" do
    old_subscription_id = account.stripe_subscription_id

    visit root_url
    visit account_path(account)
    click_link "Change Plan"
    click_link "Cancel your subscription"
    expect(page).to have_content("Your subscription has been cancelled.")

    account.reload
    expect(account.stripe_subscription_id).to be_blank
    active_subscriptions = customer.subscriptions.all
    expect(active_subscriptions.count).to eq(0)
  end

  scenario "can be updated" do
    silver_plan = Plan.create(
      name: "Silver",
      stripe_id: "silver",
      projects_allowed: 20,
      amount: 1500
    )

    visit root_url
    visit account_path(account)
    click_link "Change Plan"
    click_button "choose_silver"

    customer = Stripe::Customer.retrieve(account.stripe_customer_id)
    subscription = customer.subscriptions.retrieve(account.stripe_subscription_id)
    expect(subscription.plan.id).to eq(silver_plan.stripe_id)

    account.reload
    # expect(account.plan).to eq(silver_plan)
    expect(page).to have_content("You have changed to the Silver plan.")
  end

  scenario "is prompted to upgrade plan when over limit" do
    starter_plan = Plan.create!(
      name: "Starter",
      stripe_id: "starter",
      projects_allowed: 1,
      id: 1,
    )

    silver_plan = Plan.create!(
      name: "Silver",
      stripe_id: "silver",
      projects_allowed: 3,
      id: 2
    )

    account.plan_id = starter_plan.id
    account.projects << FactoryGirl.create(:project)
    account.save

    visit root_url
    visit account_path(account)
    click_link "Projects"
    click_link "New Project"

    message = "You have reached your plan's limit." + "You need to upgrade your plan to add more projects."
    expect(page).to have_content(message)

    click_button "choose_silver"

    expect(page).to have_content("You have changed to the Silver plan.")
    # expect(page.current_url).to eq(new_account_project_url)
  end
end
