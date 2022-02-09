class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = params[:proposal]
    @freelancer_user = @proposal.freelancer_user.profile.socialname
    @owner = @proposal.project.regular_user.email
    mail(to: @owner,
         subject: "Nova proposta para seu projeto")
  end
end
