require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  context "as an account owner" do
    let!(:account) { FactoryGirl.create(:account)}

    let!(:starter_plan) do
      Plan.create(
        name: "Starter",
        stripe_id: "starter",
        projects_allowed: 5,
        id: 1
      )
    end

    let!(:silver_plan) do
      Plan.create(
        name: "Silver",
        stripe_id: "silver",
        projects_allowed: 20,
        id: 2
      )
    end

    before do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user).and_return(account.owner)
      allow(controller).to receive(:current_account).and_return(account)

      account.plan = silver_plan
      account.projects << FactoryGirl.create_list(:project, 20)
      account.save
    end

    context "with 20 projects" do
      it "cannot switch to starter plan" do
        expect(Stripe::Customer).not_to receive(:retrieve)

        put :switch, params: { account_id: account.id, plan_id: starter_plan.id }
        expect(flash[:alert]).to eq(
          "You cannot switch to that plan." +
          " Your account is over that plan's limit."
        )
        expect(response).to redirect_to(account_choose_plan_path)

        account.reload
        expect(account.plan).to eq(silver_plan)
      end
    end
  end
end
