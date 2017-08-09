class InvitationMailer < ApplicationMailer
  def invite(invitation, account)
    @account = account
    @invitation = invitation
    mail(
      to: invitation.email,
      subject: "Invitation to join #{invitation.account.name} on Yrsa"
    )
  end
end
