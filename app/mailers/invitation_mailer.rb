class InvitationMailer < ApplicationMailer
  def invite(invitation, project, account)
    @project = project
    @invitation = invitation
    @account = account
    mail(
      to: invitation.email,
      subject: "Invitation to join project #{invitation.project.title} on #{account.name}"
    )
  end
end
