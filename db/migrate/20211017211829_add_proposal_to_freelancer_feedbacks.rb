# frozen_string_literal: true

class AddProposalToFreelancerFeedbacks < ActiveRecord::Migration[6.1]
  def change
    add_reference :freelancer_feedbacks, :proposal, null: false, foreign_key: true
  end
end
