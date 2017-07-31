module Accounts
  class Accounts::InvitationsController < Accounts::BaseController
    before_action :authorize_owner!

    def new
      @invitation = Invitation.new
    end

    def create
      @invitation = current_account.invitations.new(invitation_params)
      @invitation.save
      InvitationMailer.invite(@invitation).deliver_later
      flash[:notice] = "#{@invitation.email} has been invited."
      redirect_to root_path
    end

    def create
      @invitation = current_account.invitations.new(invitation_params)
      @invitation.save
      InvitationMailer.invite(@invitation).deliver_later
      flash[:notice] = "#{@invitation.email} has been invited."
      redirect_to root_path
    end
    
    private

    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def authorize_owner!
      unless owner?
        flash[:alert] = "Only an owner of the account can do that."
        redirect_to root_url
      end
    end
  end
end
