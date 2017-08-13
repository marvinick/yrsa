class PlansController < BaseController

  def choose
    @plans = Plan.order(:amount)
  end

  def chosen
    current_account.plan_id = params[:account][:plan_id]
    current_account.save
    flash[:notice] = "Your account has been created."
    redirect_to root_url
  end
end
