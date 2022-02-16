# frozen_string_literal: true

class MailDeliveryJob < ApplicationJob
  queue_as :default

  def perform(proposal_id)
    proposal = Proposal.find(proposal_id)
    proposal.notify_new_application.deliver
  end
end
