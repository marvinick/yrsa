class InvitationsController < BaseController
  before_action :set_account
  # before_action :set_project
  skip_before_action :authenticate_user!, only: [:accept, :accepted]
  skip_before_action :authorize_user!, only: [:accept, :accepted]
  before_action :authorize_owner!, except: [:accept, :accepted]

  def index
    @invitations = current_account.invitations.all
  end

  def new
    @project = current_account.projects.find_by slug: params[:project_id]
    @invitation = @project.invitations.build
  end

  def create
    @invitation = current_account.invitations.new(invitation_params)
    @invitation.account_id = current_account.id
    @invitation.save
    InvitationMailer.invite(@invitation, @account).deliver_now
    flash[:notice] = "#{@invitation.email} has been invited."
    redirect_to account_users_path(current_account)
  end

  def accept
    store_location_for(:user, request.fullpath)
    @invitation = Invitation.find_by!(token: params[:id])
  end

  def accepted
    @invitation = Invitation.find_by!(token: params[:id])

    if user_signed_in?
      user = current_user
    else
      user_params = params[:user].permit(
        :email,
        :password,
        :password_confirmation
      )

      user = User.create!(user_params)
      sign_in(user)
    end

    current_account.users << user

    flash[:notice] = "You have joined the #{current_account.name} account."
    redirect_to root_url
  end

  private

  def set_project
    @project = current_account.projects.find_by slug: params[:project_id]
  end

  def set_account
    @account = Account.find_by slug: params[:account_id]
  end

  def invitation_params
    params.require(:invitation).permit(:email, :account_id)
  end
end
