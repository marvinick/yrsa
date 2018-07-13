class AccountsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_account, only: [:edit, :update, :show, :upgrade]
  respond_to :html, :json

  def index; end

  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      customer = Stripe::Customer.create(
        description: @account.name,
        email: @account.owner.email
      )
      @account.update_column(:stripe_customer_id, customer.id)
      sign_in(@account.owner)
      redirect_to account_choose_plan_url(@account)
    else
      flash.now[:alert] = "Sorry, your account could not be created."
      render :new
    end
  end

  def edit; end

  def update
    if @account.update(account_params)
      customer = Stripe::Customer.retrieve(
        description: @account.name,
        email: @account.owner.email
      )
      @account.update_column(:stripe_customer_id, customer.id)

      flash[:notice] = "You've updated the account."
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = "Please enter your password to confirm."
      render "edit"
    end
  end

  def show
    @projects = @account.projects.all
    respond_with(@projects)
  end

  private

  def set_account
    @account = Account.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Account not found."
      redirect_to account_path(@account)
  end

  def account_params
    params.require(:account).permit(:name,
    { owner_attributes: [
      :email,
      :password,
      :password_confirmation
      ]}
    )
  end

  def set_project
    @account.projects.find_by slug: params[:project_id]
  end
end
