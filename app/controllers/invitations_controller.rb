class InvitationsController < BaseController
  skip_before_action :authenticate_user!, only: [:accept, :accepted]
  skip_before_action :authorize_user!, only: [:accept, :accepted]
  before_action :authorize_owner!, except: [:accept, :accepted]
  
  def index
    @invitations = current_account.invitations.all
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = current_account.invitations.new(invitation_params)
    @invitation.save
    InvitationMailer.invite(@invitation).deliver_now
    flash[:notice] = "#{@invitation.email} has been invited."
    redirect_to root_path
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

  def invitation_params
    params.require(:invitation).permit(:email, :account_id)
  end
end
