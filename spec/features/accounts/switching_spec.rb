require "rails_helper"

describe "Switching accounts" do
  let(:account_1) do
    FactoryGirl.create(:account,
      name: "Account #1"
    )
  end

  let(:account_2) do
    FactoryGirl.create(:account,
      name: "Account #2"
    )
  end

  before do
    account_2.users << account_1.owner
    login_as(account_1.owner)
  end

  it "can switch between accounts" do
    visit root_url

    click_link "Yrsa"
    expect(page.current_url).to eq(root_url)
    click_link "Account #2"
    expect(page.current_url).to eq(root_url)

    click_link "Yrsa"
    expect(page.current_url).to eq(root_url)
    click_link "Account #1"
    expect(page.current_url).to eq(root_url)
  end
end 
