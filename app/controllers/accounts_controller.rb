class AccountsController < ApplicationController

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    account = Account.create(account_params)
    sign_in(account.owner)
    flash[:notice] = "Your account has been created."
    redirect_to root_url
  end

  def show
    @account = Account.find(params[:id])
    @projects = Project.all
  end

  private

  def account_params
    params.require(:account).permit(:name,
    { owner_attributes: [
      :email,
      :password,
      :password_confirmation
      ]}
    )
  end
end
