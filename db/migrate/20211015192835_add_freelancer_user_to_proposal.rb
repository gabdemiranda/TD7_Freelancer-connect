class AddFreelancerUserToProposal < ActiveRecord::Migration[6.1]
  def change
    add_reference :proposals, :freelancer_user, null: false, foreign_key: true
  end
end
