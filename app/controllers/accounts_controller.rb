class AccountsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_account, only: [:edit, :update, :show]
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
      customer = Stripe::Customer.create(
        description: @account.name,
        email: @account.owner.email
      )
      @account.update_column(:stripe_customer_id, customer.id)
      reset_session
      # redirect_to root_url
      redirect_to account_path(@account)

    else
      flash.now[:alert] = "Something's wrong."
      render "edit"
    end
  end

  def show
    @projects = @account.projects.all
    respond_with(@projects)
  end

  private

  def set_account
    @account = Account.find_by slug: params[:id]
  end
  helper_method :set_account

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
  helper_method :set_project
end
